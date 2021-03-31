class UserRepositoriesQuery
  def initialize(user_login)
    @user_login = user_login
  end

  def call
    fetch_repositories
  end

  private

  def fetch_repositories
    results = GraphqlQuery.new(@user_login).call
    results.data.user.repositories.edges.map { |repository| repository.node.name }
  end
end