# frozen_string_literal: true

require 'graphql/client'
require 'graphql/client/http'

module Github
  SCHEMA_DIRECTORY_PATH = File.join(Rails.root, 'config', 'graphql').freeze
  SCHEMA_PATH = File.join(SCHEMA_DIRECTORY_PATH, 'github_schema.json').freeze

  HTTP = GraphQL::Client::HTTP.new('https://api.github.com/graphql') do
    def headers(_context)
      {
        'Authorization' => "Bearer #{Rails.application.credentials.github_personal_access_token}",
        'Accept' => 'application/vnd.github.v4+json'
      }
    end
  end

  unless File.exist?(SCHEMA_PATH)
    FileUtils.mkdir_p(SCHEMA_DIRECTORY_PATH)
    GraphQL::Client.dump_schema(HTTP, SCHEMA_PATH)
  end

  Schema = GraphQL::Client.load_schema(SCHEMA_PATH)

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
