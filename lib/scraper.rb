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

    links = student.css("div.social-icon-container").css("a")
    socials = [].uniq
    binding.pry
    links.flat_map do |i|
      socials << i.get_attribute("href")
    end
    socials.each do |value|
      case value
      when /twitter/
        @twitter = value
      when /linkedin/
        @linkedin = value
      when /github/
        @github = value
    end
    @profile_quote = student.css("div.profile-quote").text
    @bio = student.css("div.description-holder").css("p").text
    person = {:twitter => @twitter, :linkedin => @linkedin, :github => @github, :blog => @blog, :profile_quote => @profile_quote, :bio => @bio}
    binding.pry
  end

end
