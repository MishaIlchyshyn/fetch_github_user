class GraphqlQuery
  def initialize(user_login)
    @user_login = user_login
  end

  def call
    graphql_query
  end

  private

  LIMIT = 100
  USER_QUERY = Github::Client.parse <<-'GRAPHQL'
    query($user_login: String!, $limit: Int!) {
      user(login: $user_login) {
        name
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

  def graphql_query
    Github::Client.query(
      USER_QUERY,
      variables: { user_login: @user_login, limit: LIMIT }
    )
  end
end