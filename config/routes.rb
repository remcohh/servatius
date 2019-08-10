Rails.application.routes.draw do
  comfy_route :blog_admin, path: '/cms'
  comfy_route :blog, path: '/blog'
  mount Magic::Link::Engine, at: '/'
  devise_for :members, controllers: { registrations: 'registrations' }
  comfy_route :cms_admin, path: '/cms'
  # Ensure that this route is defined last

  get 'members/home', to: 'home#index', as: 'members_home'
  get 'rehearsals', to: 'rehearsals#index', as: 'rehearsals'
  get 'rehearsal/:id', to: 'rehearsals#show', as: 'rehearsal'
  put 'rehearsals/:id/decline', to: 'rehearsals#decline', as: 'decline_rehearsal'
  put 'rehearsals/:id/remove_decline', to:  'rehearsals#remove_decline', as: 'remove_rehearsal_decline'
  get 'gigs', to: 'gigs#index', as: 'gigs'
  get 'gig/:id', to: 'gigs#show', as: 'gig'
  put 'gig/:id/accept', to: 'gigs#accept', as: 'accept_gig'
  put 'gig/:id/decline', to: 'gigs#decline', as: 'decline_gig'

  namespace :admin do
    resources :bands
    resources :ensembles do
      post 'ensemble_instruments', to: 'ensembles#add_instrument'
      delete 'ensemble_instruments/:id', to: 'ensembles#delete_instrument', as: 'ensemble_instrument'
    end
    resources :gigs
    resources :instruments
    resources :rehearsals
    resources :members do
      get 'send_login_link', to: 'members#send_login_link'
      get 'send_reset_password_link', to: 'members#send_reset_password_link'
      post 'ensemble_instruments', to: 'members#add_ensemble_instrument'
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
