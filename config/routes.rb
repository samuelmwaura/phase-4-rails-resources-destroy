Rails.application.routes.draw do
  #resources :birds, only: [:index, :show, :create, :update,:destroy] #We are noe using all the five routes of the rest convention
  resources :birds  #We use this when we have actions in the controller handling all the five routes of the restful convention
  patch "/birds/:id/like", to: "birds#increment_likes"
end
