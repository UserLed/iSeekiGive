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
          if session[:user_type].present?
            @user = create_and_validate_from(provider)

            update_authentication_with_token(provider)

            update_user_with_type(session[:user_type])

            reset_session # protect from session fixation attack
          
            auto_login(@user)
            redirect_to @user, :notice => "Logged in from #{provider.titleize}!"
          else
            reset_session
            flash[:alert] = "Please Sign Up first!"
            redirect_to root_path
          end
        rescue => e
          logger.info "!!! External login error : #{e.message}"
          redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
        end
      end
    rescue OAuth2::Error
      redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
    end
  end


  private
  def access_token(provider)
    @provider = Config.send(provider)
    @provider.access_token
  end

  def user_hash(provider)
    @provider = Config.send(provider)
    @provider.get_user_hash
  end

  def update_authentication_with_token(provider)
    token = access_token(provider)
    @auth = @user.authentications.last
    @auth.token = token.token
    if provider.eql?("facebook")
      @auth.secret = token.client.secret
      @auth.expires_at = Time.at(token.expires_at.to_i)
    elsif provider.eql?("linkedin")
      @auth.secret = token.secret
      @auth.expires_at = Time.at(token.params[:oauth_expires_in].to_i)
    end
    @auth.save
  end

  def update_user_with_type(user_type)
    @user.type = user_type.capitalize.classify
    @user.save
    if @user.iseeker?
      @user = Iseeker.find(@user.id)
    else
      @user = Igiver.find(@user.id)
    end
  end
end
