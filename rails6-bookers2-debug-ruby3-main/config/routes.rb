Rails.application.routes.draw do

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/following', as: "following"
    get 'relationships/followers', as: "followers"
  end

  get "search" => "searches#search"

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
end
