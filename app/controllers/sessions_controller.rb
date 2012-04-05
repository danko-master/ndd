class SessionsController < ApplicationController
  
  def new
  end
  
  def create
     user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = t('activerecord.errors.controllers.message.attributes.auth.auth_error')
      @title = t('page.admin_auth_welcome_header')
      render 'new'
    else
      sign_in user
      #flash.now[:success] = t('activerecord.errors.controllers.message.attributes.auth.auth_success')
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
 
end
