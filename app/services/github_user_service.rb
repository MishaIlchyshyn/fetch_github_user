# frozen_string_literal: true

class GithubUserService
  def initialize(params)
    @user_login = params
  end

  def repositories
    fetch_repositories
  end

  def user_name
    fetch_user_name
  end

  private

  attr_reader :user_login, :user_data

  def user_data
    @user_data ||= GraphqlQuery.new(user_login).result&.data&.user
  end

  def fetch_repositories
    user_data.nil? ? [] : user_data.repositories.edges.map { |repository| repository.node.name }
  end

  def fetch_user_name
    user_data.nil? ? 'not found' : user_data.name
  end
end
