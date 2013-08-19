require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "reset_password_email" do
    mail = Notification.reset_password_email
    assert_equal "Reset password email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
