class UserNameQuery
  def initialize(user_login)
    @user_login = user_login
  end

  def call
    fetch_user
  end

  private

  def fetch_user
    results = GraphqlQuery.new(@user_login).call
    results.data.user.name
  end
end