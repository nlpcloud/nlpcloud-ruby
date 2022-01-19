# frozen_string_literal: true

require 'json'
require 'rest-client'

module NLPCloud
  BASE_URL = 'https://api.nlpcloud.io'
  API_VERSION = 'v1'

  # Client requests the API.
  class Client
    def initialize(model, token, gpu: false, lang: '')
      @headers = {
        'Authorization' => "Token #{token}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'nlpcloud-ruby-client'
      }

      @root_url = if gpu && (lang != '')
                    "#{BASE_URL}/#{API_VERSION}/gpu/#{lang}/#{model}"
                  elsif gpu && (lang == '')
                    "#{BASE_URL}/#{API_VERSION}/gpu/#{model}"
                  elsif !gpu && (lang != '')
                    "#{BASE_URL}/#{API_VERSION}/#{lang}/#{model}"
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
                   end_sequence: nil, remove_input: nil, do_sample: nil, num_beams: nil, early_stopping: nil,
                   no_repeat_ngram_size: nil, num_return_sequences: nil, top_k: nil, top_p: nil,
                   temperature: nil, repetition_penalty: nil, length_penalty: nil, bad_words: nil)
      payload = {
        'text' => text,
        'min_length' => min_length,
        'max_length' => max_length,
        'length_no_input' => length_no_input,
        'end_sequence' => end_sequence,
        'remove_input' => remove_input,
        'do_sample' => do_sample,
        'num_beams' => num_beams,
        'early_stopping' => early_stopping,
        'no_repeat_ngram_size' => no_repeat_ngram_size,
        'num_return_sequences' => num_return_sequences,
        'top_k' => top_k,
        'top_p' => top_p,
        'temperature' => temperature,
        'repetition_penalty' => repetition_penalty,
        'length_penalty' => length_penalty,
        'bad_words' => bad_words
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
