desc "Crawl fixtures data and search videos"
task :fetch_data => :environment do
  MatchCrawler.new.crawl
  Match.all.each do |m|
    s = m.time.to_s + " " + m.team_a + " "+ m.score + " " + m.team_b + "highlights"
    param = { query: s }
    Video.search(param, m)
  end
end