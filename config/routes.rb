Ndd::Application.routes.draw do



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


    resources :sessions, :only => [:new, :create, :destroy] 
    
      match '/signin',  :to => 'sessions#new' # вход в админку
      match '/signout', :to => 'sessions#destroy'
      match '/enter',  :to => 'sessions#new' # вход в админку, альтернативный путь
      match '/reset',  :to => 'users#forgot', :as => 'reset' # Сброс пароля 
      match '/reset_password/:reset_code',  :to => 'users#reset_password', :as => 'reset_password'
      
   namespace :ckeditor do
      resources :pictures, :only => [:index, :create, :destroy]
      resources :attachment_files, :only => [:index, :create, :destroy]
      resources :attachments, :only => [:index, :create, :destroy]
    end
      
      match '*url' => 'errors#routing'

end
