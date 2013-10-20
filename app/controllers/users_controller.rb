class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :activate, :resend_confirmation]

  def index
    
  end

  def new
    @user = User.new
    @type = session[:user_type]
  end

  def create
    @user = User.new(params[:user])
    @user.role = session[:user_type]
    
    if @user.save
      auto_login(@user)
      redirect_to dashboard_path, :notice => "Successfully Signed Up!"
    else
      @password = params[:user][:password]
      @password_confirmation = params[:user][:password_confirmation]
      render :action  => "new"
    end
  end

  def edit
    @step = params[:step].to_i or 0
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

    if params[:locations].present?
      @user.locations.each{|l| l.destroy }
      params[:locations].split("+").each do |location|
        @user.locations.create(:name => location)
      end
    end

    if params[:user][:profile_photo].present?
      render :crop
    else
      redirect_to request.referrer, :notice => "Successfully Updated"
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      auto_login(@user)
      redirect_to dashboard_path, :notice => 'User was successfully activated.'
    else
      not_authenticated
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    @user.resend_activation_email!
    redirect_to request.referrer, :notice => "Please check your email to activate your account!"
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

  def show
    #@user = User.find(params[:id])
    @user = current_user
    #    user_field = Rails.application.config.sorcery.linkedin.user_info_fields
    #    if current_user.have_linked_in_account?
    #      linked_in_data = current_user.connection_info('linkedin')
    #      client = LinkedIn::Client.new
    #      client.authorize_from_access(linked_in_data.first.token, linked_in_data.first.secret)
    #      user_social_data = client.profile(:fields => user_field)
    #      UserDetails.update_user_social_info(user_social_data,current_user)
    #    end
    redirect_to dashboard_path
  end

  def public_profile
    @user = User.find(params[:id])
    @user_perspectives = @user.perspectives.where(:anonymous => false)
    @user_perspectives.each do |p|
      p.update_column(:viewed, p.viewed+1)
    end
  end
end
