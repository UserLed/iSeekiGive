class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:activate, :resend_confirmation]

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      auto_login(@user)
      if @user.seeker?
        redirect_to seeker_perspectives_path(@user), :notice => 'User was successfully activated.'
      else
        redirect_to dashboard_giver_path(@user), :notice => 'User was successfully activated.'
      end
    else
      not_authenticated
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    @user.resend_activation_email!
    redirect_to request.referrer, :notice => "Please check your email to activate your account!"
  end

  def account

  end


  def popup
    @popup = current_user.popups.where("controller = ? AND action = ?", params[:con], params[:act])
    if @popup.blank?
      @popup = current_user.popups.new
      @popup.controller = params[:con]
      @popup.action = params[:act]
      @popup.status = false
      @popup.save
    else
      @popup.first.status = false
      @popup.first.save
    end
    render :text => "ok"
  end

  def email_checker
    @verified = false
    @verified = true if User.email_verified?(params[:email])
  end

  def dashboard
    @user = User.find(params[:id])
  end

  def show
    #@user = User.find(params[:id])
    @user = current_user
    user_field = Rails.application.config.sorcery.linkedin.user_info_fields
    if current_user.have_linked_in_account?
      linked_in_data = current_user.connection_info('linkedin')
      client = LinkedIn::Client.new
      client.authorize_from_access(linked_in_data.first.token, linked_in_data.first.secret)
      user_social_data = client.profile(:fields => user_field)
      UserDetails.update_user_social_info(user_social_data,current_user)
    end
  end

  def public_profile
    @user = User.find(params[:id])
    @user_perspectives = @user.perspectives.where(:anonymous => false).sample(4)
    @user_perspectives.each do |p|
      p.update_column(:viewed, p.viewed+1)
    end
  end

  def save_perspective
    unless current_user.saved_perspectives.exists?(:perspective_id => params[:p])
      perspective = current_user.saved_perspectives.build(:perspective_id => params[:p])
      if perspective.save
        @user_perspectives = current_user.perspectives.where(:anonymous => false).sample(4)
        respond_to do |format|
          format.js
        end
      else
        render :nothing => true
      end
    end
  end

end
