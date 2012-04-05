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
      match '/registration',  :to => 'users#new'


    resources :sessions, :only => [:new, :create, :destroy]    
      match '/signup',  :to => 'users#new'
      match '/signin',  :to => 'sessions#new'
      match '/signout', :to => 'sessions#destroy'

end
