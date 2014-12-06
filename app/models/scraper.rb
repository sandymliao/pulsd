class Scraper
  attr_reader :path
  def initialize(path)
    @path = "http://#{path}"
  end
  
  def fetch
    @response = RestClient.get(path)
  end

  def parse(selector)
    html = Nokogiri::HTML(@response)

    html.css(selector).each do |element|
      yield element
    end
  end
end
