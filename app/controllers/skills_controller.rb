class SkillsController < ApplicationController
  def update
    @skill = Skill.find(params[:id])
    @skill.update_attributes(params[:skill])
    redirect_to request.referrer
  end
end