class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    begin
      if @user = login_from(provider)
        redirect_to @user, :notice => "Logged in from #{provider.titleize}!"
      else
        begin
          @user = create_and_validate_from(provider)

          if @user.present? and @user.type.blank?
            @user.type = session[:user_type].capitalize.classify
            @user.save
          end

          reset_session # protect from session fixation attack

          if @user.iseeker?
            @user = Iseeker.find(@user.id)
          else
            @user = Igiver.find(@user.id)
          end
          
          auto_login(@user)
          redirect_to @user, :notice => "Logged in from #{provider.titleize}!"
        rescue
          redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
        end
      end
    rescue OAuth2::Error
      redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
    end
  end

end
