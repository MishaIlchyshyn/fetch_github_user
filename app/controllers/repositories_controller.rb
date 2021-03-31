class RepositoriesController < ApplicationController
  def index
    @repositories = if search_params[:query].present?
      UserRepositoriesService.new(search_params[:query]).call
    else
      []
    end

    @user_name = if search_params[:query].present?
      UserNameService.new(search_params[:query]).call
    else
      []
    end
  end

  private

  def search_params
    search_params = params[:search]
    search_params ? search_params.permit(:query) : {}
  end
end