class FetchGithubUserService
  def initialize(github_login)
    @github_login = github_login
  end

  def call
    fetch_user_from_github(@github_login)
  end

  private

  def fetch_user_from_github(github_login)
    @user = github_login
  end
end