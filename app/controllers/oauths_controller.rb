class OauthsController < ApplicationController
  skip_before_filter :require_login
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    session[:social_type] = params[:social_type]
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    begin
      if current_user
        if provider_account_not_exists?(provider)
          if provider.eql?("linkedin")
            create_connection(provider) unless current_user.linkedin_connected?
            UserDetails.update_user_profile(user_hash(provider), current_user)
            redirect_to dashboard_path, :notice => "Profile is updated from #{provider.titleize}!"
          elsif provider.eql?("facebook")
            create_connection(provider) unless current_user.facebook_connected?
            redirect_to dashboard_path, :notice => "Connected to #{provider.titleize}!"
          elsif provider.eql?("twitter")
            create_connection(provider) unless current_user.twitter_connected?
            redirect_to dashboard_path, :notice => "Connected to #{provider.titleize}!"
          end
        else
          redirect_to dashboard_path, :alert => "Already connected with this #{provider.titleize} account!"
        end

      elsif session[:social_type] == "sign_up"
        if session[:user_type].present?
          begin
            @user = create_and_validate_from(provider)
            unless @user.new_record?
              update_authentication_with_token(provider)
              update_user_with_type(session[:user_type], provider)
              reset_session # protect from session fixation attack
              auto_login(@user)
              redirect_to dashboard_path
            else
              if @user.present? and @user.errors.present? and @user.errors.messages[:email].present?
                flash[:alert] = "This email address is already registered!"
              else
                flash[:alert] = "Failed to sign up from #{provider.titleize}!"
              end
              redirect_to signup_path
            end
          rescue => e
            logger.info "!!! External sign up error : #{e.message}"
            redirect_to signup_path, :alert => e.message
          end
        else
          reset_session
          redirect_to signup_path, :alert => "Something went wrong! Please try again."
        end

      elsif session[:social_type] == "login"

        if @user = login_from(provider)
          redirect_to dashboard_path
        else
          redirect_to login_path, :alert => "You are not registered by this provider!"
        end
      else

        redirect_to root_path, :alert => "Something went wrong! Please try again."
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
    @user_hash ||= provider_user_data(provider)
  end

  def provider_user_data(provider)
    @provider = Config.send(provider)
    @provider.get_user_hash(access_token(provider))
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

  def update_user_with_type(user_type, provider)
    @user.type = user_type.capitalize.classify
    if provider.eql?("facebook")
      @user.date_of_birth = user_hash(provider)[:user_info]["birthday"].to_date.strftime("%Y-%d-%m").to_s if user_hash(provider)[:user_info]["birthday"].present?
    end
    @user.save
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

  def provider_account_not_exists?(provider)
    user_provider_info = user_hash(provider)
    Connection.provider_account_not_exists?(user_provider_info, provider)
  end

end
