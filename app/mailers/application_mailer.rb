class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def email_content(recipient, html)
    @html = html
    mail(to: recipient, subject: 'Weekly Stats')
  end

  def send_weekly_stats_email(user, week_number, weekly_stats_html)
    @user = user
    @week_number = week_number
    @weekly_stats_html = weekly_stats_html

    mail to: @user.email, subject: 'Weekly Stats'
    puts ActionMailer::Base.deliveries.inspect
  end
end
