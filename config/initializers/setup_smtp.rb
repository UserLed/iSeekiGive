ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "iSeekiGive.com",
    :user_name            => "contact@mhbweb.com",
    :password             => "qwerty$123",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }