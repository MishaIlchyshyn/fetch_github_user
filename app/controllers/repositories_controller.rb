class RepositoriesController < ApplicationController
  def index
    if search_params[:query].present?
      @repositories = UserRepositoriesQuery.new(search_params[:query]).call
      @user_name = UserNameQuery.new(search_params[:query]).call
    else
      @repositories = []
      @user_name = ''
    end
  end

  private

  def search_params
    search_params = params[:search]
    search_params ? search_params.permit(:query) : {}
  end
end