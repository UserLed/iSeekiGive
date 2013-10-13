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


  def privacy_policy
  end



  def get_all_users_with_tags
    term   = params[:term]
# perspective tag
    perspective_tag_search = PerspectiveTag.where("name LIKE ?", "%#{term}%" )
    perspectives  = perspective_tag_search.collect(&:perspective_id).uniq 
    perspective_tag_user_ids = Perspective.find(perspectives).collect(&:user_id)

# education
    education_search = Education.where("school_name LIKE ? OR degree LIKE ? or field_of_study LIKE ?", "%#{term}%","%#{term}%","%#{term}%")
    education_user_ids = education_search.collect(&:user_id)

# User
    user_search = User.where("first_name LIKE ? OR last_name LIKE ? OR country LIKE ? OR city LIKE ?", "%#{term}%","%#{term}%","%#{term}%","%#{term}%" )
    user_search_ids = user_search.collect(&:id)

# experience
    experience_search = Experience.where("title LIKE ? or company_name LIKE ?", "%#{term}%","%#{term}%")
    experience_user_ids = experience_search.collect(&:user_id)

# perspective
    perspective_search =  Perspective.where("story LIKE ? or story_type LIKE ?", "%#{term}%", "%#{term}%")
    perspective_user_ids = perspective_search.collect(&:user_id)


    user_ids = perspective_tag_user_ids + education_user_ids + experience_user_ids + perspective_user_ids
    user_ids = user_ids.uniq

    all_user_id = User.pluck(:id)
    user_ids = user_ids.select{|id| all_user_id.include?(id)}

    users = User.find(user_ids) || [] 
    users = users - [current_user] if logged_in?
    render :json => users.collect{|user| {:name => user.full_name, :user_id => user.id, :icon => user.profile_photo.public_profile.url || "/assets/default_user.png", :location => [user.city, user.country].compact.join(", "), :companies => user.experiences.collect{|e| [e.title, e.company_name].join(", ")}.join("<br/>"), :educations => user.educations.collect(&:school_name).join("<br/>") }}
  end

  def how_it_works

  end

  def about_us
    #render :layout => 'demo_layout'
  end
end
