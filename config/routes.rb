Rails.application.routes.draw do
  root to: "pages#show", defaults: { slug: "index" }, as: :home_page

  get "/about", to: "pages#show", defaults: { slug: "about" }, as: :about_page
  get "/essays/:slug", to: "pages#show", as: :essay_page
  get "/topics/:topic_slug/essays/:slug", to: "pages#show", as: :topic_essay_page

  get "/topics/:topic_slug", to: "pages#show", defaults: { slug: "index" }, as: :topic

  namespace :authoring do
    resources :essays, only: [ :index, :edit, :update, :create, :destroy ]
    resources :topics, only: [ :index, :create, :destroy ]
    resource :settings, only: [ :edit, :update ]
    resources :images, only: [ :index, :create, :destroy ]

    resources :essays do
      post "/topics/:topic_id", to: "essay_topics#create", as: :add_topic
      delete "/topics/:topic_id", to: "essay_topics#destroy", as: :remove_topic
      patch "/primary_topic/:topic_id", to: "essay_topics#promote", as: :promote_topic
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
