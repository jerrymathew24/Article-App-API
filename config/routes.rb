Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'auth/sign_up', to: 'registrations#create'
        post 'auth/sign_in', to: 'sessions#create'
      end
    end
  end
end