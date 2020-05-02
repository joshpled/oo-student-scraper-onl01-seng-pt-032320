require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    students.css("div.roster-cards-container").flat_map do |student|
      student.css("div.student-card").collect do |person|
        @name = person.css("h4.student-name").text
        @location = person.css("p.student-location").text
        @profile_url = person.css("div.a href").text
        {:name => @name, :location => @location, :profile_url => @profile_url}

  end
  end
binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
