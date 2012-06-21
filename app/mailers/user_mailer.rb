class UserMailer < ActionMailer::Base
  default from: "noreply@ddnurlati.ru"


   def reset_password_email(user)
    @user = user
    
    @url = reset_password_url(@user.reset_code) 
    mail(:to => user.email, :subject => t('emailer.pass_reset.subject'))
  end
  
end
