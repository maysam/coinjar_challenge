# frozen_string_literal: true

Rails.application.routes.draw do
  root 'history#index'
  get 'history/:product', to: 'history#history', as: 'history'

  post 'capture', to: 'history#capture' #, as: 'capture'
end
