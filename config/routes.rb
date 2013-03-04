Odaacabeef::Application.routes.draw do

  root :to => 'public/home#index'

  scope :module => 'public' do
    get :opscode, :to => 'opscode#index'
  end
end
