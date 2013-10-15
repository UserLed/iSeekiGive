class StoriesController < ApplicationController

  def good_stories
  	@stories = Perspective.where(:story_type => "The Good")
  end

  def bad_stories
  	@stories = Perspective.where(:story_type => "The Bad")
  end

  def ugly_stories
  	@stories = Perspective.where(:story_type => "The Ugly")
  end

end