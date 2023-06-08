Rails.application.routes.draw do
  resource :example, constraints: -> { Rails.env.development? }
  get 'about', to: 'pages#about'
  root 'pages#home'
end
