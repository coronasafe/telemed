Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'contacts#summary'

  get 'search', to: 'contacts#search'

  get 'find_phone' => "contacts#find_phone"

  resources :contacts, except: [:destroy] do
    get :make_call, on: :member
    get :generate_non_medical_reqs, on: :collection
    get :generate_medical_reqs, on: :collection
    get :summary, on: :collection

    resources :consultations, only: %w[create]
    resources :prescriptions, only: %w[create new]
  end

  resources :consultations do
    get :versions, on: :member
    get :copy, on: :member
    resources :followups, only: %w[create] do
      get :complete, on: :member
    end
  end

  resources :prescriptions, only: %w[show edit update index] do

  end
end
