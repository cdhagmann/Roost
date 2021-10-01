# frozen_string_literal: true

module API
  class FavoritesController < ApplicationController
    before_action :set_favorite, only: %i[create destroy]

    # GET api/users/:user_id/posts/:post_id/favorites
    def index
      @favorites = Favorite.all.where('post_id=?', params[:cluck_id])
    end

    # POST api/users/:user_id/posts/:post_id/favorites
    def create
      if @favorite
        render json: { error: "You can't favorite the same post twice." }, status: :conflict
      else
        @favorite = Favorite.new(post_id: params[:cluck_id], user_id: current_user.id)
        if @favorite.save
          render :show, status: :created, location: api_rooster_cluck_favorites_path(@user, @favorite.post_id)
        else
          render json: @favorite.errors, status: :unprocessable_entity
        end
      end
    end

    # DELETE api/users/:user_id/posts/:post_id/favorites
    def destroy
      if @favorite
        @favorite.destroy
      else
        render json: { error: "You don't have permission to destroy this resource" }, status: :unauthorized
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    private def set_favorite
      @favorite = Favorite.where('post_id=?', params[:cluck_id]).where('user_id=?', current_user.id)[0]
      @user = current_user
    end
  end
end
