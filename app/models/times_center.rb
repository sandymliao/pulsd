require_relative 'scraper.rb'
require 'date'

class TimesCenter
  attr_reader :events
  def initialize
    @events = []
    scraper = Scraper.new("thetimescenter.com/calendar.php")
    scraper.fetch
    scraper.parse('div#column-left-general .tcEvent') do |ele|
     event = {}
     event[:name] = ele.css('h4 a').text
     date_converter = '%m/%d/%y'
     end_date = ele.css('h3').text
     new_end = Date.strptime(end_date, date_converter)
     event[:start_date] = "N/A"
     event[:end_date] = new_end.strftime("%B %d, %Y")
     event[:time] = "N/A"
     event[:location] = "The Times Center, 242 West 41st Street, NYC 10036"
     @events << event
    end
    p @events
  end
end
