require_relative 'scraper.rb'
require 'date'

class ChelseaMarket
  attr_reader :events
  def initialize
    @events = []
    scraper = Scraper.new("chelseamarket.com/index.php/Events")
    scraper.fetch
    scraper.parse('div#page-content .category-item') do |ele|
      event = {}
      event[:name] = ele.css('.item-title').text
      date_converter = ' %B %d, %Y'
      start_date = ele.css('.from-date').text.concat(", 2014")
      new_start = Date.strptime(start_date, date_converter)
      event[:start_date] = new_start.strftime("%B %d, %Y")
      end_date = ele.css('.to-date').text.concat(", 2014")
      new_end = Date.strptime(end_date, date_converter)
      event[:end_date] = new_end.strftime("%B %d, %Y")
      event[:time] = "Monday - Saturday: 7am to 9pm, Sunday: 8am to 8pm"
      event[:location] = "Chelsea Market at 75 9th Avenue (Btwn 15th and 16 Streets), New York, NY 10011"
      @events << event
    end
    p @events
  end
end
