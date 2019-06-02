require './scraper'
scraper = Scraper.new 'https://www.trycaviar.com/peninsula/rise-pizzeria-6431'
result = scraper.parse
scraper.write_result
# scraper.read_result
scraper.prints_result
