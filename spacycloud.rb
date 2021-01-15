# frozen_string_literal: true

module SpacyCloud
  BASE_URL = 'https://api.spacycloud.io'
  API_VERSION = 'v1'

  # Client requests the API.
  class Client
    def initialize(model, token)
      token_header = puts "Token #{token}"
      @headers = {
        'Authorization' => token_header
      }
      @root_url = puts "#{BASE_URL}/#{API_VERSION}/#{model}"
    end

    def entities(user_input)
      @headers = user_input
    end
  end
end
