Rails.application.routes.draw do

  post "todos", to: "todos#create"
  get "todos", to: "todos#index"

  get "todos/new", to: "todos#new"

  get "todos/:id", to: "todos#show"
  put "todos/:id", to: "todos#update"
  delete "todos/:id", to: "todos#destroy"

  root to: "todos#index"
end
