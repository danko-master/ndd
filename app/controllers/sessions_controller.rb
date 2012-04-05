class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = t('activerecord.errors.controllers.message.attributes.auth.auth_error')
      render 'new'
    else
      sign_in user
      flash.now[:success] = t('activerecord.errors.controllers.message.attributes.auth.auth_success')
      #render 'success'
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  def success
  end
  
end
