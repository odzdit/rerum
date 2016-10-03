class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

private

    def after_sign_in_path_for(resource)
       "/dashboard"
    end

end