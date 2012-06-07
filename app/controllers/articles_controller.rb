class ArticlesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :new, :create, :destroy]
    
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 10).order("date DESC, created_at DESC")
  end
  
  def show
    @main = Main.first
    @article = Article.find(params[:id])
    
  end
  
  def edit  
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
    @d = Date.current()
    @article[:date] = @d.strftime(t('date.formats.default'))
  end
    
  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_create_success')
      redirect_to articles_path
    else
      render 'new'
    end
  end
    
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      redirect_to @article
    else
      render 'edit'
    end  
  end
    
  def destroy
    Article.find(params[:id]).destroy

    flash[:success] = t('activerecord.errors.controllers.message.attributes.page.page_destroy_success')
    redirect_to articles_path
  end
  
  
  private

    def authenticate
      deny_access unless signed_in?
    end
  
end
