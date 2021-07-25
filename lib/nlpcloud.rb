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
        'Authorization' => "Token #{token}",
        "User-Agent": 'nlploud-ruby-client'
      }
      @root_url = "#{BASE_URL}/#{API_VERSION}/#{model}"
    end

    def entities(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/entities", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def classification(text, labels, multi_class)
      payload = {
        'text' => text,
        'labels' => labels,
        'multi_class' => multi_class
      }
      response = RestClient.post("#{@root_url}/classification", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def sentiment(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/sentiment", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def question(context, question)
      payload = {
        'context' => context,
        'question' => question
      }
      response = RestClient.post("#{@root_url}/question", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def summarization(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/summarization", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def translation(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/translation", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def dependencies(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/dependencies", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def sentence_dependencies(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/sentence-dependencies", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def lib_versions
      response = RestClient.get("#{@root_url}/versions", @headers)
      JSON.parse(response.body)
    end
  end
end
