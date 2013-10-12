class TagsController < ApplicationController

  before_filter :require_login
  
  def create
    @tag = current_user.tags.new(params[:tag])
    @tag.save

    respond_to do |format|
      format.js
      format.html {redirect_to request.referrer}
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update_attributes(params[:tag])
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end
	
	def get_user_tags
		if request.post? and params[:tag].present? 
			unless current_user.tags.exists?(:name => params[:tag])
				current_user.tags.build(:name => params[:tag]).save!
				render :nothing => true
				return
			end
    end

		tags =  current_user.tags.collect{|tag| tag.name}
		render :json => tags
	end
end
