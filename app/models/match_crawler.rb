class MatchCrawler
  MATCH_IDS = {
    "Premier League" => {
      league_id: 17950,
      start_page: -6
    },
    "Primera Division" => {
      league_id: 18383,
      start_page: -6
    },
    "UEFA Champions League" => {
      league_id: 17916,
      start_page: -4
    }
  }

  def self.crawl_all
    crawler = MatchCrawler.new
    MATCH_IDS.each do |league, info|
      puts "Crawling matches of #{league}"
      crawler.crawl(info[:league_id], info[:start_page])
    end

    return
  end

  def crawl(league_id, from_page)
    conn = Faraday.new(url: 'http://www.soccerway.com/') do |c|
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Adapter::NetHttp
    end

    result = []

    for i in from_page..0 do
      response = conn.get request_param(league_id, i)
      json = JSON.parse response.body
      html = Nokogiri.HTML json["commands"][0]["parameters"]["content"]
      result << process_html(html)
    end

    result.flatten!
    puts "Crawled #{result.count} matches\n\n"
  end

  def request_param(league_id, page)
    path = '/a/block_competition_matches?'
    callback_params = {
      page: (page==0 ? 0 : page.to_s),
      round_id: league_id.to_s,
      outgroup: "",
      view: 2
    }
    params = {
      block_id: "page_competition_1_block_competition_matches_7",
      callback_params: callback_params.to_json,
      action: "changePage",
      params: { page: (page+1==0 ? 0 : (page+1).to_s) }.to_json
    }

    path + params.to_query
  end

  def process_html(html)
    results = []
    html.css('table.matches > tbody > tr').each do |tr|
      timestamp = tr['data-timestamp'].to_i
      next if (timestamp > Time.now.to_i)

      time = Time.at timestamp
      team_a = tr.css('td.team-a > a').first[:title]
      team_b = tr.css('td.team-b > a').first[:title]
      score = tr.css('td.score > a').first.text if tr.css('td.score > a').first
      match = {
        time: time,
        team_a: team_a,
        team_b: team_b,
        score: score
      }

      puts "Crawled match: #{time} | #{team_a} #{score} #{team_b}"
      Match.save_match(match)
      results << match
    end
    results
  end
end