# frozen_string_literal: true

require 'json'
require 'rest-client'

module NLPCloud
  BASE_URL = 'https://api.nlpcloud.io'
  API_VERSION = 'v1'

  # Client requests the API.
  class Client
    def initialize(model, token, gpu: false, lang: '', asynchronous: false)
      @headers = {
        'Authorization' => "Token #{token}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'nlpcloud-ruby-client'
      }

      @root_url = "#{BASE_URL}/#{API_VERSION}/"

      if lang == "en"
        lang = ""
      end
      if lang == "eng_Latn"
        lang = ""
      end

      if gpu
        @root_url += "gpu/"
      end

      if asynchronous
        @root_url += "async/"
      end

      if lang != ""
        @root_url += lang + "/"
      end

      @root_url += model

    end

    def ad_generation(keywords)
      payload = {
        'keywords' => keywords
      }
      response = RestClient.post("#{@root_url}/ad-generation", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def asr(url: nil, encoded_file: nil, input_language: nil)
      payload = {
        'url' => url,
        'encoded_file' => encoded_file,
        'input_language' => input_language
      }
      response = RestClient.post("#{@root_url}/asr", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def async_result(url)
      response = RestClient.get(url, @headers)

      if response.body && !response.body.empty?
        JSON.parse(response.body)
      end
    end

    def chatbot(text, context: nil, history: nil)
      payload = {
        'text' => text,
        'context' => context,
        'history' => history
      }
      response = RestClient.post("#{@root_url}/chatbot", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def classification(text, labels: nil, multi_class: nil)
      payload = {
        'text' => text,
        'labels' => labels,
        'multi_class' => multi_class
      }
      response = RestClient.post("#{@root_url}/classification", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def code_generation(instruction)
      payload = {
        'instruction' => instruction
      }
      response = RestClient.post("#{@root_url}/code-generation", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def dependencies(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/dependencies", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def embeddings(sentences)
      payload = {
        'sentences' => sentences
      }
      response = RestClient.post("#{@root_url}/embeddings", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def entities(text, searched_entity: nil)
      payload = {
        'text' => text,
        'searched_entity' => searched_entity
      }
      response = RestClient.post("#{@root_url}/entities", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def generation(text, max_length: nil, length_no_input: nil,
                   end_sequence: nil, remove_input: nil, num_beams: nil,
                   num_return_sequences: nil, top_k: nil, top_p: nil,
                   temperature: nil, repetition_penalty: nil, bad_words: nil, remove_end_sequence: nil)
      payload = {
        'text' => text,
        'max_length' => max_length,
        'length_no_input' => length_no_input,
        'end_sequence' => end_sequence,
        'remove_input' => remove_input,
        'num_beams' => num_beams,
        'num_return_sequences' => num_return_sequences,
        'top_k' => top_k,
        'top_p' => top_p,
        'temperature' => temperature,
        'repetition_penalty' => repetition_penalty,
        'bad_words' => bad_words,
        'remove_end_sequence' => remove_end_sequence
      }
      response = RestClient.post("#{@root_url}/generation", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def gs_correction(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/gs-correction", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def image_generation(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/image-generation", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def intent_classification(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/intent-classification", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def kw_kp_extraction(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/kw-kp-extraction", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def langdetection(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/langdetection", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def paraphrasing(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/paraphrasing", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def question(question, context: nil)
      payload = {
        'question' => question,
        'context' => context
      }
      response = RestClient.post("#{@root_url}/question", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def semantic_search(text, num_results: nil)
      payload = {
        'text' => text,
        'num_results' => num_results
      }
      response = RestClient.post("#{@root_url}/semantic_search", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def semantic_similarity(sentences)
      payload = {
        'sentences' => sentences
      }
      response = RestClient.post("#{@root_url}/semantic_similarity", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def sentence_dependencies(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/sentence-dependencies", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def sentiment(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/sentiment", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def speech_synthesis(text, voice: nil)
      payload = {
        'text' => text,
        'voice' => voice
      }
      response = RestClient.post("#{@root_url}/speech-synthesis", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def summarization(text, size: nil)
      payload = {
        'text' => text,
        'size' => size
      }
      response = RestClient.post("#{@root_url}/summarization", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def tokens(text)
      payload = {
        'text' => text
      }
      response = RestClient.post("#{@root_url}/tokens", payload.to_json, @headers)
      JSON.parse(response.body)
    end

    def translation(text, source, target)
      payload = {
        'text' => text,
        'source' => source,
        'target' => target
      }
      response = RestClient.post("#{@root_url}/translation", payload.to_json, @headers)
      JSON.parse(response.body)
    end
  end
end
