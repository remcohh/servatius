Rails.application.routes.draw do
  mount Magic::Link::Engine, at: '/'
  comfy_route :cms_admin, path: '/cms'
  # Ensure that this route is defined last
  namespace :admin do
    resources :bands
    resources :gigs
    resources :instruments
    resources :rehearsals
    resources :members do
      get 'send_login_link', to: 'members#send_login_link'
      get 'send_reset_password_link', to: 'members#send_reset_password_link'
    end
  end
  # get 'members/index'
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'gig_signup/:id', to: 'gigs#signup', as: 'gig_signup'
  get 'gig_dropout/:id', to: 'gigs#dropout', as: 'gig_dropout'
  comfy_route :cms, path: '/'
  devise_for :members, controllers: { registrations: 'registrations' }

  root 'home#index'
end
