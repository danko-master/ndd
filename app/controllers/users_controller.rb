class UsersController < ApplicationController
  before_filter :authenticate # Предфильтр для вызова authenticate, распространяется на все действия
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = t('activerecord.errors.controllers.message.attributes.user.user_update_success')
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end

end
