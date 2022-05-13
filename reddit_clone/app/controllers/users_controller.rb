class UsersController < ApplicationController

    # before_action :logged_in?, only: [:show, :index, :destroy]
    before_action :require_logged_in, only: [:show]
    before_action :require_logged_out, only: [:new, :create]

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in(@user)
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def index
        render :index
    end

    def show
        @user = User.find(params[:id])
        redirect_to user_url(@user)
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to users_url
    end

    def edit
        render :edit
    end

    def update
        @user = User.find(params[:id])
        @user.update!(user_params)
        redirect_to user_url(@user)
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
