Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'activity' => 'activity#create'
      post 'buddy'    => 'buddy#create'
    end
  end
end