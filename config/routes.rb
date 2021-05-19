Rails.application.routes.draw do
  root to: "postcodes#home"

  get "/postcodes/check", to: "postcodes#check"
end
