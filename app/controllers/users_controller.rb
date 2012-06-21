class UsersController < ApplicationController
  before_filter :authenticate, :except => [:forgot, :reset_password] 
  #Предфильтр для вызова authenticate,
   #распространяется на все действия кроме указанных в  except
   
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
  
   def forgot  
      if request.post?
          user = User.find_by_email(params[:user][:email])
          if user
            user.create_reset_code              
          end
            flash[:notice] = t('helpers.notice_email')
            render :template => "sessions/new"
            #Выводим одинаковое сообщение и рендерим ту же форму в любом случае, дабы не было возможности перебора возможных пользователей         
      end
  end
    
  def reset_password
      @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?     
  
      if request.post?    
        if @user && @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
          self.current_user = @user
          @user.delete_reset_code
          flash[:success] = t('helpers.password_reset_successful')
          render :template => "sessions/new"
        else
          flash[:error] = t('helpers.password_reset_error')
          redirect_to root_path
        end
      end
   end
   
  
  private

    def authenticate
      deny_access unless signed_in?
    end

end
