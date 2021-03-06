require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    students.css("div.roster-cards-container").flat_map do |student|
      student.css("div.student-card").collect do |person|
        @name = person.css("h4.student-name").text
        @location = person.css("p.student-location").text
        @profile_url = person.css("a").attribute("href").text
        {:name => @name, :location => @location, :profile_url => @profile_url}
  end
  end
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    links = student.css("div.social-icon-container").css("a")
    links.flat_map do |link|
      value = link.attribute("href").value
      if value.match?(/twitter/)
        student_hash[:twitter] = value
      elsif value.match?(/linkedin/)
        student_hash[:linkedin] = value
      elsif value.match?(/github/)
        student_hash[:github] = value
      else
        student_hash[:blog] = value
      end
    end
    student_hash[:profile_quote] = student.css("div.profile-quote").text
    student_hash[:bio] = student.css("div.description-holder").css("p").text
    student_hash
  end

end
