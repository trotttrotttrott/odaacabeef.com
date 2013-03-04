Odaacabeef::Application.routes.draw do

  root :to => 'public/home#index'

  scope :module => 'public' do

    namespace :opscode do
      get '/', :action => 'index'
      get :run_command
      get :tail_command
    end
  end
end
