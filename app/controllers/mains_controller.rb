class MainsController < ApplicationController
  def show
    @main = Main.first
  end

  def edit
    @main = Main.first
  end
  
  def update
    @main = Main.first
    if @main.update_attributes(params[:main])
      flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      redirect_to root_path
    else
      render 'edit'
    end
  end

end
