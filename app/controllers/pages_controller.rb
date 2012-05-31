class PagesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :new, :create, :index, :destroy]
  
  def show    
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      redirect_to @page
    else
      render 'edit'
    end  
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_create_success')
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def index
    @pages = Page.order("order_id")    
  end
  
 
  
  def destroy
    Page.find(params[:id]).destroy
        
    @pagechildren =  Page.where("parent_id = ?", params[:id])   
    @pagechildren.update_all({parent_id: -1}) if @pagechildren.count > 0
    
    
    flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_destroy_success')
    redirect_to pages_path
  end
  
  def sort
    params[:page].each_with_index do |id, index|
      Page.update_all({order_id: index+1}, {id: id})
    end  
  end
  
  def level
      Page.update(params[:id], :parent_id => params[:parent_id])
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end

end
