Rails.application.routes.draw do
  mount Magic::Link::Engine, at: '/'
  devise_for :members, controllers: { registrations: 'registrations' }
  comfy_route :cms_admin, path: '/cms'
  # Ensure that this route is defined last

  get 'members/home', to: 'home#index', as: 'members_home'
  get 'rehearsals', to: 'rehearsals#index', as: 'rehearsals'
  get 'rehearsal/:id', to: 'rehearsals#show', as: 'rehearsal'
  put 'rehearsals/:id/decline', to: 'rehearsals#decline', as: 'decline_rehearsal'
  put 'rehearsals/:id/remove_decline', to:  'rehearsals#remove_decline', as: 'remove_rehearsal_decline'

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

  root 'home#index'
end
