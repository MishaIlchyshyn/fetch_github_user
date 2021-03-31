class UserRepositoriesService
  def initialize(user_login)
    @user_login = user_login
  end

  LIMIT = 100
  SEARCH_REPOSITORY_META_QUERY = Github::Client.parse <<-'GRAPHQL'
    query($user_login: String!, $limit: Int!) {
      user(login: $user_login) {
        repositories(first: $limit) {
          edges {
            node {
              name
            }
          }
        }
      }
    }
  GRAPHQL

  def call
    fetch_repositories(@user_login)
  end

  private

  def fetch_repositories(user_login)
    results = Github::Client.query(
      SEARCH_REPOSITORY_META_QUERY,
      variables: { user_login: user_login, limit: LIMIT }
    )
    results.data.user.repositories.edges.map { |repository| repository.node.name }
  end
end