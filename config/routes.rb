Odaacabeef::Application.routes.draw do

  root :to => 'public/home#index'

  scope :module => 'public' do

    namespace :opscode do
      get '/', :action => 'index'
      get :about_node_monitor
      get :gist
      get :run
      get :tail
    end

    namespace :trotttrotttrott do
      get 'public-key', :action => 'public_key'
    end
  end
end
