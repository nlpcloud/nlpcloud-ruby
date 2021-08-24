# frozen_string_literal: true

require 'json'
require 'rest-client'

module NLPCloud
  BASE_URL = 'https://api.nlpcloud.io'
  API_VERSION = 'v1'

  # Client requests the API.
  class Client
    def initialize(model, token, gpu: false)
      @headers = {
        'Authorization' => "Token #{token}",
        'User-Agent' => 'nlpcloud-ruby-client'
      }

      @root_url = if gpu
                    "#{BASE_URL}/#{API_VERSION}/gpu/#{model}"
                  else
                    "#{BASE_URL}/#{API_VERSION}/#{model}"
                  end
    end

    def entities(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/entities", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def classification(text, labels, multi_class: nil)
      payload = {
        'text' => text,
        'labels' => labels,
        'multi_class' => multi_class
      }
      response = RestClient.post("#{@root_url}/classification", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def generation(text, min_length: nil, max_length: nil, length_no_input: nil,
                   end_sequence: nil, remove_input: nil, top_k: nil, top_p: nil,
                   temperature: nil, repetition_penalty: nil, length_penalty: nil)
      payload = {
        'text' => text,
        'min_length' => min_length,
        'max_length' => max_length,
        'length_no_input' => length_no_input,
        'end_sequence' => end_sequence,
        'remove_input' => remove_input,
        'top_k' => top_k,
        'top_p' => top_p,
        'temperature' => temperature,
        'repetition_penalty' => repetition_penalty,
        'length_penalty' => length_penalty
      }
      response = RestClient.post("#{@root_url}/generation", payload.to_json, @headers)
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

    def langdetection(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/langdetection", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def tokens(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/tokens", payload.to_json, @headers)
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
