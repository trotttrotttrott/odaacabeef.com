Odaacabeef::Application.routes.draw do

  root :to => 'public/home#index'

  devise_for :admins
  match '/admin' => 'admin/home#index', :as => :admin_root
end
