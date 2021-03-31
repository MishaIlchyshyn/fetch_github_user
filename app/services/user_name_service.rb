class UserNameService
  def initialize(user_login)
    @user_login = user_login
  end

  LIMIT = 100
  SEARCH_REPOSITORY_META_QUERY = Github::Client.parse <<-'GRAPHQL'
    query($user_login: String!) {
      user(login: $user_login) {
        name
      }
    }
  GRAPHQL

  def call
    fetch_user(@user_login)
  end

  private

  def fetch_user(user_login)
    results = Github::Client.query(
      SEARCH_REPOSITORY_META_QUERY,
      variables: { user_login: user_login }
    )
    results.data.user.name
  end
end