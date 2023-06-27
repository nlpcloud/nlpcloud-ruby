Gem::Specification.new do |s|
  s.name = 'nlpcloud'
  s.version     = '1.0.42'
  s.summary     = 'Ruby client for the NLP Cloud API'
  s.description = 'NLP Cloud serves high performance pre-trained or custom models for NER, sentiment-analysis, classification, summarization, paraphrasing, grammar and spelling correction, keywords and keyphrases extraction, chatbot, product description and ad generation, intent classification, text generation, image generation, code generation, question answering, automatic speech recognition, machine translation, language detection, semantic search, semantic similarity, speech synthesis, tokenization, POS tagging, embeddings, and dependency parsing. It is ready for production, served through a REST API. This is the Ruby client for the API. More details here: https://nlpcloud.io. Documentation: https://docs.nlpcloud.io.'
  s.authors     = ['Julien Salinas']
  s.email       = 'all@juliensalinas.com'
  s.files       = [
    'lib/nlpcloud.rb'
  ]
  s.homepage    = 'https://github.com/nlpcloud/nlpcloud-ruby'
  s.license     = 'MIT'
  s.metadata = {
    'documentation_uri' => 'https://docs.nlpcloud.com',
    'homepage_uri' => 'https://nlpcloud.com',
    'source_code_uri' => 'https://github.com/nlpcloud/nlpcloud-ruby'
  }
  s.add_runtime_dependency "rest-client", "~> 2.1"
end
