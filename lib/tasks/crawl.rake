desc "Crawl fixtures data and search videos"
task :fetch_data => :environment do
  MovieCrawler.new.crawl(2011, 1)
  Movie.all.each do |m|
    s = m.title + m.year.to_s + "official trailer"
    param = { query: s, page: 1, per_page: 10 }
    Video.search(param, m)
  end
end