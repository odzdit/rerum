Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
root to: 'static_pages#home'
get '/about-us' => 'static_pages#about_us'


# dashboard
get '/dashboard' => 'dashboard#dashboard'
get '/dashboard-test' => 'dashboard#dashboard_test'
get '/yearly-report' => 'dashboard#yearly_report'
get '/monthly-report' => 'dashboard#monthly_report'
get '/weekly-dashboard-impressions' => 'dashboard#weekly_dashboard_impressions'
get '/weekly-dashboard-cost' => 'dashboard#weekly_dashboard_cost'
get '/weekly-dashboard-conversions' => 'dashboard#weekly_dashboard_conversions'
get '/weekly-dashboard-ctr' => 'dashboard#weekly_dashboard_ctr'


get "login/prompt"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
