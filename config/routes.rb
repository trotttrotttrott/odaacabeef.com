Trotttrotttrott::Application.routes.draw do

  root :to => 'public/home#index'

  devise_for :admins
  match '/admin' => 'admin/home#index', :as => :admin_root
  namespace :admin do

    authenticate :admin do
      mount Resque::Server.new, :at => '/resque'
    end
  end

end

