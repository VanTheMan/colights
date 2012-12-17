desc "Crawl fixtures data and search videos"
task :fetch_data => :environment do
  MovieCrawler.new.crawl(2012, 0)
  Movie.all.each do |m|
    s = m.title + m.year.to_s + "official trailer"
    param = { query: s, page: 1, per_page: 3 }
    Video.search(param, m) unless m.crawled
  end
end