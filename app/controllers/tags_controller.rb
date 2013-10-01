class TagsController < ApplicationController

	before_filter :require_login
	
	def get_user_tags
		if request.post? and params[:tag].present? 
			unless Tag.exists?(:name => params[:tag])
				current_user.tags.build(:name => params[:tag]).save!
				render :nothing => true
				return
			end
		end

		tags =  current_user.tags.collect{|tag| tag.name}
		render :json => tags
	end
end
