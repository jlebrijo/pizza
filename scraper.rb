require 'watir'
require 'webdrivers/chromedriver'

class Scraper
  def initialize(url)
    @browser = Watir::Browser.new
    @browser.goto url
  end

  def parse
    @result = @browser.divs(class: 'offer-tile_meta-container').map do |e|
      e.click
      {
        name: e.h4(class: 'offer-tile_name').text,
        modifiers: get_modifiers,
        price: e.span(class: 'offer-tile_price').text
      }
    end
  end

  def get_modifiers
    Watir::Wait.until { @browser.h2(class: "item_name").present? }
    modifiers = @browser.divs(class: 'item_modifier-option').map { |m| m.text }
    @browser.button(class:'modal_close').click
    Watir::Wait.until { ! @browser.div(class: "modal-backdrop").present? }
    modifiers
  end

  def write_result
    File.write 'result.txt', @result
  end

  def read_result
    @result = eval File.read('result.txt')
  end

  def prints_result
    @result.each do |p|
      puts '----------------------------'
      puts "#{p[:name]} - #{p[:price]}"
      if p[:modifiers].any?
        puts 'Modifiers:'
        p[:modifiers].each do |m|
          puts "       #{m}"
        end
      end
    end
  end

end
