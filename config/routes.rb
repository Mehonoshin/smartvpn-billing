# frozen_string_literal: true

Smartvpn::Application.routes.draw do
  require 'sidekiq/web'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :billing do
    root to: 'home#index'

    resources :payments, only: %i[index new create] do
      member do
        get :merchant
      end
    end
    resources :promotions, only: [:create]
    resources :options, only: %i[index create update destroy] do
      put :toggle, on: :member
    end
    resources :referrers, only: [:index]
    resources :servers, only: [:index] do
      get :download_config, on: :member
    end

    scope '/webmoney' do
      get 'fail', to: 'webmoney#fail', as: :webmoney_fail
      get 'success', to: 'webmoney#success', as: :webmoney_success
      match 'result', to: 'webmoney#result', as: :webmoney_result, via: %i[get post]
    end

    scope '/robokassa' do
      get 'fail', to: 'robokassa#fail', as: :robokassa_fail
      get 'success', to: 'robokassa#success', as: :robokassa_success
      post 'result', to: 'robokassa#result', as: :robokassa_result
    end

    scope '/paypal' do
      get 'fail', to: 'paypal#fail', as: :paypal_fail
      get 'success', to: 'paypal#success', as: :paypal_success
      match 'result', to: 'paypal#result', as: :paypal_result, via: %i[get post]
    end
  end

  namespace :admin do
    root to: 'home#index'
    resources :servers do
      get :generate_config, on: :member
    end
    resources :plans
    resources :pay_systems, except: :destroy
    resources :users, except: :destroy do
      collection do
        get :payers
        get :this_month_payers
        get :emails_export
      end
      member do
        put :withdraw
        put :prolongate
        put :payment
        put :enable_test_period
        put :disable_test_period
        put :force_disconnect
      end
    end
    resources :connections, only: %i[index show] do
      get :active, on: :collection
    end
    resources :traffic_reports, only: [:index] do
      collection do
        get :users
        get :date
        get :servers
      end
    end
    resources :transactions, only: [:index] do
      collection do
        get :payments
        get :withdrawals
      end
    end
    resources :promos, only: %i[index new create edit update]
    resources :options, only: %i[index new create edit update]
    resources :referrers, only: [:index]
  end

  namespace :api do
    match '/activate', to: 'servers#activate', via: [:post]
    match '/auth', to: 'authentication#auth', via: [:post]
    match '/disconnect', to: 'connection#disconnect', via: [:post]
    match '/connect', to: 'connection#connect', via: [:post]
  end

  match '/referrer', to: 'referrers#set_referrer', via: [:get]
  root to: 'main#index'

  authenticate :admin do
    mount Sidekiq::Web, at: '/sidekiq'
    mount PgHero::Engine, at: 'pghero'
  end
end
