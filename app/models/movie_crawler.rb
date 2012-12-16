require 'open-uri'

class MovieCrawler
  def crawl(year = Time.now.year)
    @crawl_year = year
    
    movies = []

    for i in 1..2 do
      movies << process_page(i)
    end

    movies.flatten!
    movies.count
  end

  def process_page(page)
    page = open("http://www.boxofficemojo.com/yearly/chart/?yr=#{@crawl_year}&page=#{page}")
    html = Nokogiri.HTML(page)

    results = []
    odd_rows = html.css("tr[bgcolor='#ffffff']")
    odd_rows.pop

    even_rows = html.css("tr[bgcolor='#f4f4ff']")
    even_rows.pop

    rows = odd_rows + even_rows
    rows.each do |row|
      results << process_row(row)
    end

    results
  end

  def process_row(html)
    rank = html.css('td:nth-child(1) font').first.text.to_i
    title = html.css('td:nth-child(2) a').first.text
    studio = html.css('td:nth-child(3) a').first[:href][/(?<=\?studio=)\w+(?=.htm)/]
    gross = html.css('td:nth-child(4) b').first.text.gsub(/[\$,]/, '').to_i
    
    attributes = {
      rank: rank,
      title: title,
      year: @crawl_year,
      gross: gross,
      studio: studio
    }

    puts "Crawled movie: #{rank} | #{title} (#{@crawl_year}) | $#{gross} | #{studio}"
  end
end