require_relative 'scraper.rb'
require 'date'

class RadioCity
  attr_reader :events
  def initialize
    @events = []
    scraper = Scraper.new("radiocity.com/calendar")
    scraper.fetch
    scraper.parse('tbody.active tr') do |ele|
      event = {}
      next if ele.css('td').empty?
      event[:name] = ele.css('.event_name a').text
      date_converter = '%b %d, %Y'
      if ele.css('.event_date').text.match("-") 
       if ele.css('.event_date').text.match(/Dec/)
         start_date = ele.css('.event_date').text.split(" - ")[0].concat(", 2014")
         end_date = ele.css('.event_date').text.split(" - ")[1].concat(", 2015")
         new_start = Date.strptime(start_date, date_converter)
         new_end = Date.strptime(end_date, date_converter)
         event[:start_date] = new_start.strftime("%B %d, %Y")
         event[:end_date] = new_end.strftime("%B %d, %Y")
       else
         start_date = ele.css('.event_date').text.split(" - ")[0].concat(", 2015")
         end_date = ele.css('.event_date').text.split(" - ")[1].concat(", 2015")
         new_start = Date.strptime(start_date, date_converter)
         new_end = Date.strptime(end_date, date_converter)
         event[:start_date] = new_start.strftime("%B %d, %Y")
         event[:end_date] = new_end.strftime("%B %d, %Y")
       end
      else 
        end_date = ele.css('.event_date').text.concat(", 2015")
        new_end = Date.strptime(end_date, date_converter)
        event[:start_date] = "N/A"
        event[:end_date] = new_end.strftime("%B %d, %Y")
      end
      event[:time] = ele.css('.event_time').text
      event[:location] = ele.css('.venue_loc').text
      @events << event
    end
    p @events
  end
end
