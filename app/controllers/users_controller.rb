class UsersController < ApplicationController

    before_action :authenticate_user!, except: [:show]

    def show
		@user = User.find(params[:id] || current_user.id)
    end
end
