require_relative 'scraper.rb'
require 'date'

class MadisonSquarePark
  attr_reader :events
  def initialize
    @events = []
    scraper = Scraper.new("madisonsquarepark.org/things-to-do")
    scraper.fetch
    scraper.parse('.post-wrapper .post') do |ele|
      event = {}
      event[:name] = ele.css('h1.post-title a').text
      date_converter = ' %b %d, %Y '
      if ele.css('.date-time').text.match(/\–/)
        end_date = ele.css('.date-time').text.split("–")[0].strip.concat(", 2014")
        new_end = Date.strptime(end_date, date_converter)
        event[:end_date] = new_end.strftime("%B %d, %Y")
        event[:time] = ele.css('.date-time').text.split("–")[1].strip
      elsif ele.css('.date-time').text.match(/\-/)
        start_date = ele.css('.date-time').text.split("-")[0].strip.concat(", 2015")
        end_date = ele.css('.date-time').text.split("-")[1].strip
        new_start = Date.strptime(start_date, date_converter)
        new_end = Date.strptime(end_date, date_converter)
        event[:start_date] = new_start.strftime("%B %d, %Y")
        event[:end_date] = new_end.strftime("%B %d, %Y")
      end    
      event[:location] = "Madison Square Park"
      @events << event
    end
    p @events
  end
end
