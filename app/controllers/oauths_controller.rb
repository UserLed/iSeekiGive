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
      if current_user
        if provider.eql?("linkedin")
          create_connection(provider) unless current_user.linkedin_connected?
          UserDetails.update_user_profile(user_hash(provider), current_user)
          redirect_to current_user, :notice => "Profile is updated from #{provider.titleize}!"
        elsif provider.eql?("facebook")
          create_connection(provider) unless current_user.facebook_connected?
          redirect_to current_user, :notice => "Connected to #{provider.titleize}!"
        elsif provider.eql?("twitter")
          create_connection(provider) unless current_user.twitter_connected?
          redirect_to current_user, :notice => "Connected to #{provider.titleize}!"
        end

      elsif @user = login_from(provider)
        redirect_to @user, :notice => "Logged in from #{provider.titleize}!"
      else
        
        begin
          if session[:user_type].present?
            @user = create_and_validate_from(provider)
            unless @user.new_record?
              update_authentication_with_token(provider)
              update_user_with_type(session[:user_type])
              reset_session # protect from session fixation attack
              auto_login(@user)
              redirect_to @user, :notice => "Logged in from #{provider.titleize}!"
            end
          else
            reset_session
            redirect_to root_path, :alert => "Please sign up first!"
          end
        rescue => e
          logger.info "!!! External login error : #{e.message}"
          redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
        end
        
      end
      
      if @user.present? and @user.errors.present? and @user.errors.messages[:email].present?
        redirect_to root_path, :alert => "This email address is already used!"
      end
      
    rescue OAuth2::Error => e
      logger.info "!!! External login error : #{e.message}"
      redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
    end
  end


  private
  def access_token(provider)
    @provider = Config.send(provider)
    @access_token ||= @provider.process_callback(params, session)
  end

  def user_hash(provider)
    @provider = Config.send(provider)
    @user_hash ||= @provider.get_user_hash(access_token(provider))
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
      @auth.expires_at = Time.at(Time.now.to_i + token.params[:oauth_expires_in].to_i)
      @provider = Config.send(provider)
      UserDetails.update_user_profile(user_hash(provider), @user)
    end
    @auth.save
  end

  def update_user_with_type(user_type)
    @user.type = user_type.capitalize.classify

    if @user.provider == "facebook"
      location = @user.country.split(", ")
      @user.city = location.first
      @user.country = location.last
    end

    @user.save
    if @user.seeker?
      @user = Seeker.find(@user.id)
    else
      @user = Giver.find(@user.id)
    end
  end

  def create_connection(provider)
    token = access_token(provider)
    user_info = user_hash(provider)
        
    @connection = current_user.connections.new
    @connection.provider = provider
    @connection.uid = user_info[:uid]
    @connection.token = token.token
    if provider.eql?("facebook")
      @connection.secret = token.client.secret
      @connection.expires_at = Time.at(token.expires_at.to_i)
    elsif provider.eql?("linkedin")
      @connection.secret = token.secret
      @connection.expires_at = Time.at(Time.now.to_i + token.params[:oauth_expires_in].to_i)
    elsif provider.eql?("twitter")
      @connection.secret = token.secret
    end
    @connection.save
  end
end
