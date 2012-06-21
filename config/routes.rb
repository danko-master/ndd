Ndd::Application.routes.draw do

 # get "pages/show"

 # get "pages/edit"

 # get "mains/edit"

   #путь к главной странице
    root :to => 'mains#show'
    
    #пути к ресурсам контроллеров      
    resources :mains
    resources :pages do
      collection { post :sort, :level }
    end
    
    resources :users do
      collection { post :forgot, :reset_password }
    end
    
    resources :articles


    resources :sessions, :only => [:new, :create, :destroy] #do
      #collection do
         #get :passrecovery
         #post :forgot, :reset_password
      #end
    #end
    
      match '/signin',  :to => 'sessions#new' # вход в админку
      match '/signout', :to => 'sessions#destroy'
      match '/enter',  :to => 'sessions#new' # вход в админку, альтернативный путь
      match '/reset',  :to => 'users#forgot', :as => 'reset' # Сброс пароля 
      match '/reset_password/:reset_code',  :to => 'users#reset_password', :as => 'reset_password'
      
      match '*url' => 'errors#routing'

end
