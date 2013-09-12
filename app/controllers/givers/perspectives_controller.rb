class Givers::PerspectivesController < ApplicationController
  before_filter :require_login

  def index
    @giver = Giver.find(params[:giver_id])
  end

  def game_1
    @giver = Giver.find(params[:giver_id])
  end
  
  def game_2
  	@giver_skills = current_user.skills
  	@giver_experiences = current_user.experiences
  	@giver_experiences_count = (1..@giver_experiences.count).to_a
  end

  def open_single_experience
  	@giver_skills = current_user.skills
  	@giver_experience = current_user.experiences.find(params[:experience_id])
  end

  def save_game_tag
  	if params[:tag_name].present? && params[:experience_name].present? && params[:user_id].present?
  		create_tag = SaveGameTag.create(:tag_name => params[:tag_name], :experience_name => params[:experience_name], :user_id => params[:user_id].to_i)
  	end
  	if create_tag && !create_tag.errors.any?
  		render :text => :ok
  		return
  	
  	else
  		render :text => "something went wrong"
  		return
  	end
  end

end