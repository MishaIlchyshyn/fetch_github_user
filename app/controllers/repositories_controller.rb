class RepositoriesController < ApplicationController
  def index
    @repositories = GithubUserService.new(search_params[:query]).repositories
    @user_name = GithubUserService.new(search_params[:query]).user_name
  end

  private

  def search_params
    search_params = params[:search]
    search_params ? search_params.permit(:query) : {}
  end
end