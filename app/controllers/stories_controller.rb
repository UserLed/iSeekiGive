class StoriesController < ApplicationController
  #before_filter :require_login

  def good_stories
  	@good_stories = Perspective.all.select{|story| story.story_type.eql?("The Good")}
  end

  def bad_stories
  	@bad_stories = Perspective.all.select{|story| story.story_type.eql?("The Bad")}
  end

  def ugly_stories
  	@ugly_stories = Perspective.all.select { |story| story.story_type.eql?("The Ugly")}
  end

end