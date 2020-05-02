Rails.application.routes.draw do
  mount Spina::Engine => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Spina::Engine.routes.draw do
    resources :schools, only: [:index, :show
  ]
    namespace :admin, path: Spina.config.backend_path do
      resources :schools
    end
  end
end
