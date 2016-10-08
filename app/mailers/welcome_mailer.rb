class WelcomeMailer < ApplicationMailer
default from: "dieterordonez@gmail.com"
    def new_user(user)
        @user = user
        mail(to: "dieterordonez@gmail.com", subject: "New user, #{@user.name}")
    end

end
