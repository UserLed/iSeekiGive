class Notification < ActionMailer::Base
  default :from => "\"iSeekiGive\" <info@iSeekiGive.com>"
  
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    headers['X-SMTPAPI'] = "{\"category\" : \"Password Help\"}"
    mail(:to => user.email,
      :subject => "Your password reset instructions")
  end

  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(:to => user.email,
      :subject => "Email activation required")
  end

  def  activation_success_email(user)
    @user = user
    @url  = login_url
    mail(:to => user.email,
      :subject => "Email activated.")
  end
end
