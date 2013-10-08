class StoriesController < ApplicationController
  before_filter :require_login,:except => [:index]

  def index
    perspectives = Perspective.all
    @good_stories = perspectives.select{|story| story.story_type.eql?("The Good")}
    @bad_stories = perspectives.select{|story| story.story_type.eql?("The Bad")}
    @ugly_stories = perspectives.select{|story| story.story_type.eql?("The Ugly")}
    @users = User.find(perspectives.collect(&:user_id).uniq)
  end

end