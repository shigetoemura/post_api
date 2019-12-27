Rails.application.routes.draw do
	namespace :api, defaults: { format: 'json' } do
		namespace :v1 do
			resource :guest_user, only: [:create]
			resource :sign_up, only: [:create]
			resources :groups, only: [:create, :show, :update, :index] do
				resources :group_members, only: [:create]
				resources :group_posts, only: [:create, :index]
				resources :group_questions, only: [:create, :index]
				member do
					put :upload_icon
					put :upload_background
				end
			end
			resources :group_members, only: [:update, :destroy, :show] do
				member do
					put :upload_icon
					put :upload_background
					post :follow
					post :unfollow
					post :report
				end
			end
			resources :group_posts, only: [:show, :update, :destroy] do
				member do
					put :upload_icon
					post :favorite
					post :unfavorite
					post :report
				end
				collection do
					get :guest_timeline
				end
			end
			resources :group_questions, only: [:show, :update, :destroy] do
				member do
					put :upload_icon
				end
				collection do
					get :guest_timeline
				end
				resources :group_answers, only: [:create, :index]
			end
			resources :group_answers, only: [:show, :update, :destroy] do
				member do
					put :upload_icon
					post :favorite
					post :unfavorite
					post :report
				end
			end
			resources :notifications, only: [:index]
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
