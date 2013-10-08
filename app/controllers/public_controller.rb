class PublicController < ApplicationController
  def index

  end

  def signup
    if current_user.present?
      redirect_to current_user
    elsif params[:type]
      session[:user_type] = params[:type]
      @type = session[:user_type]
      render 'signup_form', :layout => false
    end
  end

  def terms_of_service
  end

  def terms_and_condition

  end

  def privacy
  end


  def search_for_user
    term   = params[:tag]
    result = PerspectiveTag.where("name=?", term )
    perspectives  = result.collect(&:perspective_id).uniq unless result.blank?
    user_ids = Perspective.find(perspectives).uniq.collect(&:user_id) unless perspectives.blank? 
    @users = User.find(user_ids) unless user_ids.blank? 
  end



  def get_all_users_with_tags
    term   = params[:term]
    result = PerspectiveTag.where("name LIKE ?", "%#{term}%" )
    perspectives  = result.collect(&:perspective_id).uniq unless result.blank?
    user_ids = Perspective.find(perspectives).uniq.collect(&:user_id) unless perspectives.blank? 
    users = (User.find(user_ids) unless user_ids.blank?) || [] 
    render :json => users.collect{|user| {:label => user.full_name, :value => user.id, :icon => user.profile_photo.public_profile.url.to_s, :country => user.country}}
  end

  def how_it_works

  end

  def about_us
    #render :layout => 'demo_layout'
  end
end
