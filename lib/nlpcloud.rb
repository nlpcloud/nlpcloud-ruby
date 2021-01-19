# frozen_string_literal: true

require 'json'
require 'rest-client'

module NLPCloud
  BASE_URL = 'https://api.nlpcloud.io'
  API_VERSION = 'v1'

  # Client requests the API.
  class Client
    def initialize(model, token)
      @headers = {
        'Authorization' => "Token #{token}"
      }
      @root_url = "#{BASE_URL}/#{API_VERSION}/#{model}"
    end

    def entities(user_input)
      api_post('entities', user_input)
    end

    def dependencies(user_input)
      api_post('dependencies', user_input)
    end

    def sentence_dependencies(user_input)
      api_post('sentence-dependencies', user_input)
    end

    def lib_versions
      api_get('version')
    end

    private

    def api_post(endpoint, user_input)
      payload = {
        'text' => user_input
      }
      response = RestClient.post("#{@root_url}/#{endpoint}", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def api_get(endpoint)
      response = RestClient.get("#{@root_url}/#{endpoint}", @headers)
      JSON.parse(response.body)
    end
  end
end
