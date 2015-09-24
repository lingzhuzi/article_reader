Rails.application.routes.draw do
  resources :articals do
    get 'download', on: :collection
  end

  resources :reader_configs do
    post 'run', on: :member
  end
  resources :tasks, only: [:index, :show, :destroy]

  root 'reader_configs#index'
end
