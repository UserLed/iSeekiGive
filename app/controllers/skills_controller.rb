class SkillsController < ApplicationController
  def update
    @skill = Skill.find(params[:id])
    @skill.update_attributes(params[:skill])
    @updated_skill = Skill.find(params[:id])
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def create
    @skill = current_user.skills.new(params[:skill])
    @skill.save
    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end
end