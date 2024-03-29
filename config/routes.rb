Rails.application.routes.draw do
  comfy_route :blog_admin, path: '/cms'
  comfy_route :blog, path: '/blog'
  mount Magic::Link::Engine, at: '/'
  devise_for :members, controllers: { registrations: 'registrations', sessions: 'members/sessions' }
  comfy_route :cms_admin, path: '/cms'
  # Ensure that this route is defined last

  get 'home', to: 'home#index', as: 'app_home'
  get 'leden', to: redirect('/messages'), as: 'members_messages'
  get 'members', to: redirect('/messages')
  get 'profile', to: 'members#profile', as: 'profile'
  get 'edit_password', to: 'members#edit_password', as: 'edit_password'
  put 'update_password', to: 'members#update_password', as: 'update_password'
  get 'rehearsals', to: 'rehearsals#index', as: 'rehearsals'
  get 'rehearsal/:id', to: 'rehearsals#show', as: 'rehearsal'
  get 'rehearsal/:id/presence', to: 'rehearsals#presence', as: 'rehearsal_presence'
  put 'rehearsal/:id/presence', to: 'rehearsals#set_presence_status', as: 'rehearsal_presence_update'

  get 'rehearsal/:id/registrations', to: 'rehearsals#registrations', as: 'rehearsal_registrations'
  put 'rehearsal/:id/registration', to: 'rehearsals#set_registration_status', as: 'rehearsal_registration_update'

  put 'rehearsals/:id/accept', to: 'rehearsals#accept', as: 'accept_rehearsal'
  put 'rehearsals/:id/decline', to: 'rehearsals#decline', as: 'decline_rehearsal'
  put 'rehearsals/:id/remove_decline', to:  'rehearsals#remove_decline', as: 'remove_rehearsal_decline'
  get 'gigs', to: 'gigs#index', as: 'gigs'
  get 'gig/:id', to: 'gigs#show', as: 'gig'
  put 'gig/:id/accept', to: 'gigs#accept', as: 'accept_gig'
  put 'gig/:id/decline', to: 'gigs#decline', as: 'decline_gig'

  get 'agenda', to: 'gigs#published_gigs', as: 'published_gigs'
  get 'agenda/:id', to: 'gigs#published_gig', as: 'published_gig'

  get 'chores', to: 'chores#index', as: 'chores'
  get 'chore/:id', to: 'chores#show', as: 'chore'
  put 'chore/:id/attendance', to: 'chores#set_attendance_status', as: 'chore_attendance_update'
  get 'messageables', to: 'messageables#index', as: 'messageables'

  get 'statistics/rehearsals', to: 'rehearsals#statistics', as: 'rehearsal_statistics'
  resources :messages
  resources :songs, only: %i(index show)

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
      get 'generate_reset_password_link', to: 'members#generate_reset_password_link'
      get 'generate_password', to: 'members#generate_password'
    end
    resources :songs
    resources :chores
    resources :instruments
    resources :groups
  end
  # get 'members/index'
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'gig_signup/:id', to: 'gigs#signup', as: 'gig_signup'
  get 'gig_dropout/:id', to: 'gigs#dropout', as: 'gig_dropout'
  comfy_route :cms, path: '/'

  root 'home#index'
end
