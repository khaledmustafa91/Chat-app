# frozen_string_literal: true

Rails.application.routes.draw do
  resources :applications, param: :token, except: [:destroy] do
    resources :chats, param: :number, except: [:update, :destroy], controller: 'applications/chats' do
      resources :messages, param: :number, except: [:destroy], controller: 'applications/chats/messages' do
        collection do
          get :search
        end
      end
    end
  end
end
