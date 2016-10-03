Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
root to: 'static_pages#home'
get '/dashboard' => 'dashboard#dashboard'
get '/dashboard-test' => 'dashboard#dashboard_test'
get '/yearly-report' => 'dashboard#yearly_report'
get '/monthly-report' => 'dashboard#monthly_report'
get "login/prompt"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
