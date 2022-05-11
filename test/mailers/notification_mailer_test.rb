require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "album_notification" do
    mail = NotificationMailer.album_notification
    assert_equal "Album notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
