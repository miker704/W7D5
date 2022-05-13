class SubsController < ApplicationController

    before_action :require_logged_in, only: [:destroy, :create, :update]

    def index
        @subs = Sub.all
        redirect_to subs_url
    end

    def show
        redirect_to sub_url(sub_params[:id])
    end

    def new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash[:errors] = @sub.errors.full_messages
            redirect_to new_sub_url
        end
    end

    def edit
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])
        @sub.update(sub_params)
        redirect_to sub_url(@sub)
    end

    def destroy
        @sub = Sub.find(params[:id])
        if @sub.destroy
            redirect_to subs_url
        else
            redirect_to subs_url
        end
    end

    private

    def subs_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end
end
