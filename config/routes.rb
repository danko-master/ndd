Ndd::Application.routes.draw do

 # get "pages/show"

 # get "pages/edit"

 # get "mains/edit"

   #путь к главной странице
    root :to => 'mains#show'
    
    #пути к ресурсам контроллеров      
    resources :mains
    resources :pages
    
    resources :users


    resources :sessions, :only => [:new, :create, :destroy]    
      match '/signin',  :to => 'sessions#new' # вход в админку
      match '/signout', :to => 'sessions#destroy'
      match '/enter',  :to => 'sessions#new' # вход в админку, альтернативный путь

end
