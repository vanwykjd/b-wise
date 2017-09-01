class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def show
		@user = User.find(params[:id])
        unless @user == current_user
          redirect_to new_user_session_path, :alert => "You are not signed in."
        end
    end
end
