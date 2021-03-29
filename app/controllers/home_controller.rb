class HomeController < ApplicationController
  def index
    @user = FetchGithubUserService.new(params[:user_name]).call
  end
end