Kodiak::Application.routes.draw do

  resources :settings

  resources :galleries

  resources :search
  resources :attachments

  resources :posts

  devise_for :users

  resources :users

  resources :photos

  resources :categories

  get '/archives' => 'archives#index'
  
  get '/:year' => 'archives#year', constraints: {
    year: /\d{4}/
  }, as: :year

  get '/:year/:month' => 'archives#month', constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/
  }, as: :month

  get '/:year/:month/:day' => 'archives#day', constraints: {
    year: /\d{4}/,
    month: /\d{1,2}/,
    day: /\d{1,2}/
  }, as: :day

  get '/galleries/:id/photos/new' => 'photos#new', as: :gallery_photo

  root :to => "home#index"

  
end
