class ApplicationController < ActionController::Base
  respond_to :json, :xml
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found # Перехват несуществующих страниц
  
  before_filter :mailer_set_url_options # Определение хоста для отправки
  
  protect_from_forgery
  
  
  #for sessions
  include SessionsHelper
  
  # Для меню
  include PagesHelper
  include MainsHelper
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end  
  
# render :template => "layouts/error_handle"
 private
    def not_found
      respond_with(nil, :status => 404) do |format|
        format.html {
          render :template => "errors/error"
        }
        format.xml { render :text => {'error' => t('errors.messages.not_found_404')}.to_xml(:root => 'errors'), :status => 404 }
        format.json { render :text => {'errors' => t('errors.messages.not_found_404')}.to_json, :status => 404 }
      end
    end
end