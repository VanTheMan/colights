desc "Crawl fixtures data and search videos"
task :fetch_data => :environment do
  MatchCrawler.new.crawl
  Match.all.each do |m|
    s = m.team_a + "vs" + m.team_b + m.score + " " + "all goals and highlights" + m.time.to_s + " "
    param = { query: s }
    Video.search(param, m)
  end
end