require_relative 'scraper.rb'
require 'date'

class StrandBookstore
  attr_reader :events
  def initialize
    @events = []
    scraper = Scraper.new("www.strandbooks.com/events/")
    scraper.fetch
    scraper.parse('.v-event-list .vevent') do |ele|
     event = {}
     event[:name] = ele.css('h3 a').text
     date_converter = ' %B %d, %Y '
     end_date = ele.css('.dtstart').text.split(":")[0].strip.concat(", 2014")
     new_end = Date.strptime(end_date, date_converter)
     event[:start_date] = "N/A"
     event[:end_date] = new_end.strftime("%B %d, %Y")
     start_time = ele.css('.dtstart').text.split(":")[1].strip.concat(" - ")
     event[:time] = start_time.concat(ele.css('.dtend').text.strip)
     event[:location] = "Strand Bookstore 828 Broadway (& 12th Street), New York, NY 10003"
     @events << event
   end
   p @events
  end
end
