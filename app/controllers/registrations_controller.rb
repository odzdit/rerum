class RegistrationsController < Devise::RegistrationsController

private

    def after_sign_up_path_for(resource)
      "/dashboard-test"
    end
 
    def after_inactive_sign_up_path_for(resource)
      "/dashboard-test"
    end
end
