# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]
    skip_before_action :verify_authentication, only: [:create]

    def index
      @users = User.all
    end

    def show; end

    def profile
      @user = current_user
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if current_user.id != @user.id
        render json: { error: "You can't update this user" }, status: :unauthorized
      elsif @user.update(user_params)
        render :show, status: :updated, location: api_rooster_url(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if current_user.id != @user.id
        render json: { error: "You can't destroy this user" }, status: :unauthorized
      else
        @user.destroy
      end
    end

    private def set_user
      @user = User.find(params[:id])
    end

    private def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end
