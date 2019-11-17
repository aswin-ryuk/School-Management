Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'registrations'}, path_names: {sign_in: 'login', sign: 'logout'}
  
  resources :abouts, only: :index
 
  resources :students, except: [:show] do
		collection do
			get :link_marks
			post  :save_marks
			get :calculate_rank
		end
  end

  resources :subjects


 
   resources :report_generations,  only:  [:index] do
		collection do
			post :generate_report
			get  :generate_report
		end
  end


	#root to: "devise/sessions#new"

	#root :to => "users#login"#redirect("/users/login")
	root :to => "students#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
