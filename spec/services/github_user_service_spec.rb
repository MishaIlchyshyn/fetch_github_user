require 'rails_helper'

RSpec.describe GithubUserService do
  describe "Github user service" do
    it "return user_name when we call user_name method" do
      user_name = 'David Heinemeier Hansson'

      params = 'dhh'

      query = GithubUserService.new(params).user_name

      expect(query).to eq(user_name)
    end

    it "return repositories when we call repositories method" do
      repositories = GithubUserService.new("dhh").repositories

      params = 'dhh'

      query = GithubUserService.new(params).repositories

      expect(query).to eq(repositories)
    end
  end
end