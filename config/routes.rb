Rails.application.routes.draw do
  get 'about', to: 'pages#about'
  get 'videos', to: 'pages#videos'
  root 'pages#home'
end
