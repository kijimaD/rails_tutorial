require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  test "account_activation" do
    user = users(:example)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

end
