# Ruby Client For NLP Cloud

This is the Ruby client for the [NLP Cloud](https://nlpcloud.com) API. See the [documentation](https://docs.nlpcloud.com) for more details.

NLP Cloud serves high performance pre-trained or custom models for NER, sentiment-analysis, classification, summarization, dialogue summarization, paraphrasing, intent classification, product description and ad generation, chatbot, grammar and spelling correction, keywords and keyphrases extraction, text generation, image generation, code generation, question answering, automatic speech recognition, machine translation, language detection, semantic search, semantic similarity, tokenization, POS tagging, embeddings, and dependency parsing. It is ready for production, served through a REST API.

You can either use the NLP Cloud pre-trained models, fine-tune your own models, or deploy your own models.

If you face an issue, don't hesitate to raise it as a Github issue. Thanks!

## Installation

Install via gem.

```shell
gem install nlpcloud
```

## Examples

Here is a full example that summarizes a text using Facebook's Bart Large CNN model, with a fake token:

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("bart-large-cnn","4eC39HqLyjWDarjtT1zdp7dc")
client.summarization("One month after the United States began what has become a 
  troubled rollout of a national COVID vaccination campaign, the effort is finally 
  gathering real steam. Close to a million doses -- over 951,000, to be more exact -- 
  made their way into the arms of Americans in the past 24 hours, the U.S. Centers 
  for Disease Control and Prevention reported Wednesday. That s the largest number 
  of shots given in one day since the rollout began and a big jump from the 
  previous day, when just under 340,000 doses were given, CBS News reported. 
  That number is likely to jump quickly after the federal government on Tuesday 
  gave states the OK to vaccinate anyone over 65 and said it would release all 
  the doses of vaccine it has available for distribution. Meanwhile, a number 
  of states have now opened mass vaccination sites in an effort to get larger 
  numbers of people inoculated, CBS News reported.")
```

Here is a full example that does the same thing, but on a GPU:

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("bart-large-cnn","4eC39HqLyjWDarjtT1zdp7dc", gpu: true)
client.summarization("One month after the United States began what has become a 
  troubled rollout of a national COVID vaccination campaign, the effort is finally 
  gathering real steam. Close to a million doses -- over 951,000, to be more exact -- 
  made their way into the arms of Americans in the past 24 hours, the U.S. Centers 
  for Disease Control and Prevention reported Wednesday. That s the largest number 
  of shots given in one day since the rollout began and a big jump from the 
  previous day, when just under 340,000 doses were given, CBS News reported. 
  That number is likely to jump quickly after the federal government on Tuesday 
  gave states the OK to vaccinate anyone over 65 and said it would release all 
  the doses of vaccine it has available for distribution. Meanwhile, a number 
  of states have now opened mass vaccination sites in an effort to get larger 
  numbers of people inoculated, CBS News reported.")
```

Here is a full example that does the same thing, but on a French text:

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("bart-large-cnn","4eC39HqLyjWDarjtT1zdp7dc", gpu: true, lang: "fra_Latn")
client.summarization("Sur des images aériennes, prises la veille par un vol de surveillance 
  de la Nouvelle-Zélande, la côte d’une île est bordée d’arbres passés du vert 
  au gris sous l’effet des retombées volcaniques. On y voit aussi des immeubles
  endommagés côtoyer des bâtiments intacts. « D’après le peu d’informations
  dont nous disposons, l’échelle de la dévastation pourrait être immense, 
  spécialement pour les îles les plus isolées », avait déclaré plus tôt 
  Katie Greenwood, de la Fédération internationale des sociétés de la Croix-Rouge.
  Selon l’Organisation mondiale de la santé (OMS), une centaine de maisons ont
  été endommagées, dont cinquante ont été détruites sur l’île principale de
  Tonga, Tongatapu. La police locale, citée par les autorités néo-zélandaises,
  a également fait état de deux morts, dont une Britannique âgée de 50 ans,
  Angela Glover, emportée par le tsunami après avoir essayé de sauver les chiens
  de son refuge, selon sa famille.")
```

A json object is returned:

```json
{
  "summary_text": "Over 951,000 doses were given in the past 24 hours. That's the largest number of shots given in one day since the  rollout began. That number is likely to jump quickly after the federal government gave states the OK to vaccinate anyone over 65. A number of states have now opened mass vaccination sites."
}
```

## Usage

### Client Initialization

Pass the model you want to use and the NLP Cloud token to the client during initialization.

The model can either be a pre-trained model like `en_core_web_lg`, `bart-large-mnli`... but also one of your custom models `custom_model/<model id>` (e.g. `custom_model/2568`).

Your token can be retrieved from your [NLP Cloud dashboard](https://nlpcloud.com/home/token).

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("<model>", "<your token>")
```

If you want to use a GPU, pass `gpu: true`.

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("<model>", "<your token>", gpu: true)
```

If you want to use the multilingual add-on in order to process non-English texts, pass `lang: "<your language code>"`. For example, if you want to process French text, you should set `lang: "fra_Latn"`.

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("<model>", "<your token>", lang: "your language code")
```

If you want to make asynchronous requests, pass `asynchronous: true`.

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("<model>", "<your token>", asynchronous: true)
```

If you are making asynchronous requests, you will always receive a quick response containing a URL. You should then poll this URL with `async_result()` on a regular basis (every 10 seconds for example) in order to check if the result is available. Here is an example:

```ruby
client.async_result("https://api.nlpcloud.io/v1/get-async-result/21718218-42e8-4be9-a67f-b7e18e03b436")
```

The above command returns a JSON object.

### Automatic Speech Recognition (Speech to Text) Endpoint

Call the `asr()` method and pass the following arguments:

1. (Optional: either this or the encoded file should be set) `url`: a URL where your audio or video file is hosted
1. (Optional: either this or the url should be set) `encoded_file`: a base 64 encoded version of your file
1. (Optional) `input_language`: the language of your file as ISO code

```ruby
client.asr(url:"Your url")
```

The above command returns a JSON object.

### Chatbot Endpoint

Call the `chatbot()` method and pass your input. As an option, you can also pass a context and a conversation history that is a list of hashes. Each hash is made of an `input` and a `response` from the chatbot.

```ruby
client.chatbot("<Your input>", context: "<Your context>", history: [{"input"=>"input 1","response"=>"response 1"}, {"input"=>"input 2","response"=>"response 2"}, ...])
```

The above command returns a JSON object.

### Classification Endpoint

Call the `classification()` method and pass the following arguments:

1. The text you want to classify, as a string
1. The candidate labels for your text, as a list of strings
1. (Optional) `multi_class`: Whether the classification should be multi-class or not, as a boolean

```ruby
client.classification("<Your block of text>", labels: ["label 1", "label 2", "..."])
```

The above command returns a JSON object.

### Code Generation Endpoint

Call the `code_generation()` method and pass the instruction for the program you want to generate:

```ruby
client.code_generation("<Your instruction>")
```

The above command returns a JSON object.

### Dependencies Endpoint

Call the `dependencies()` method and pass the text you want to perform part of speech tagging (POS) + arcs on.

```ruby
client.dependencies("<Your block of text>")
```

The above command returns a JSON object.

### Embeddings Endpoint

Call the `embeddings()` method and pass a list of blocks of text that you want to extract embeddings from.

```ruby
client.embeddings(["<Text 1>", "<Text 2>", "<Text 3>", ...])
```

The above command returns a JSON object.

### Entities Endpoint

Call the `entities()` method and pass the text you want to perform named entity recognition (NER) on.

```ruby
client.entities("<Your block of text>")
```

The above command returns a JSON object.

### Generation Endpoint

Call the `generation()` method and pass the following arguments:

1. The block of text that starts the generated text. 256 tokens maximum for GPT-J on CPU, 1024 tokens maximum for GPT-J and GPT-NeoX 20B on GPU, and 2048 tokens maximum for Fast GPT-J and Finetuned GPT-NeoX 20B on GPU.
1. (Optional) `max_length`: Optional. The maximum number of tokens that the generated text should contain. 256 tokens maximum for GPT-J on CPU, 1024 tokens maximum for GPT-J and GPT-NeoX 20B on GPU, and 2048 tokens maximum for Fast GPT-J and Finetuned GPT-NeoX 20B on GPU. If `length_no_input` is false, the size of the generated text is the difference between `max_length` and the length of your input text. If `length_no_input` is true, the size of the generated text simply is `max_length`. Defaults to 50.
1. (Optional) `length_no_input`: Whether `min_length` and `max_length` should not include the length of the input text, as a boolean. If false, `min_length` and `max_length` include the length of the input text. If true, min_length and `max_length` don't include the length of the input text. Defaults to false.
1. (Optional) `end_sequence`: A specific token that should be the end of the generated sequence, as a string. For example if could be `.` or `\n` or `###` or anything else below 10 characters.
1. (Optional) `remove_input`: Whether you want to remove the input text form the result, as a boolean. Defaults to false.
1. (Optional) `num_beams`: Number of beams for beam search. 1 means no beam search. This is an integer. Defaults to 1.
1. (Optional) `num_return_sequences`: The number of independently computed returned sequences for each element in the batch, as an integer. Defaults to 1.
1. (Optional) `top_k`: The number of highest probability vocabulary tokens to keep for top-k-filtering, as an integer. Maximum 1000 tokens. Defaults to 0.
1. (Optional) `top_p`: If set to float < 1, only the most probable tokens with probabilities that add up to top_p or higher are kept for generation. This is a float. Should be between 0 and 1. Defaults to 0.7.
1. (Optional) `temperature`: The value used to module the next token probabilities, as a float. Should be between 0 and 1. Defaults to 1.
1. (Optional) `repetition_penalty`: The parameter for repetition penalty, as a float. 1.0 means no penalty. Defaults to 1.0.
1. (Optional) `bad_words`: List of tokens that are not allowed to be generated, as a list of strings. Defaults to null.
1. (Optional) `remove_end_sequence`: Optional. Whether you want to remove the `end_sequence` string from the result. Defaults to false.

```ruby
client.generation("<Your input text>")
```

The above command returns a JSON object.

### Grammar and Spelling Correction Endpoint

Call the `gs_correction()` method and pass the text you want correct:

```ruby
client.gs_correction("<Your block of text>")
```

The above command returns a JSON object.

### Image Generation Endpoint

Call the `image_generation()` method and pass the text you want to use to generate your image:

```ruby
client.image_generation("<Your block of text>")
```

The above command returns a JSON object.

### Intent Classification Endpoint

Call the `intent_classification()` method and pass the text you want to extract intents from:

```ruby
client.intent_classification("<Your block of text>")
```

The above command returns a JSON object.

### Keywords and Keyphrases Extraction Endpoint

Call the `kw_kp_extraction()` method and pass the text you want to extract keywords and keyphrases from:

```ruby
client.kw_kp_extraction("<Your block of text>")
```

The above command returns a JSON object.

### Language Detection Endpoint

Call the `langdetection()` method and pass the text you want to analyze in order to detect the languages.

```ruby
client.langdetection("<The text you want to analyze>")
```

The above command returns a JSON object.

### Library Versions Endpoint

Call the `lib_versions()` method to know the versions of the libraries used behind the hood with the model (for example the PyTorch, TensorFlow or spaCy versions used).

```ruby
client.lib_versions()
```

The above command returns a JSON object.

### Paraphrasing Endpoint

Call the `paraphrasing()` method and pass the text you want to paraphrase.

```ruby
client.paraphrasing("<Your text to paraphrase>")
```

The above command returns a JSON object.

### Question Answering Endpoint

Call the `question()` method and pass the following:

1. Your question
1. A context that the model will use to try to answer your question

```ruby
client.question(question: "<Your question>",context: "<Your context>")
```

The above command returns a JSON object.

### Semantic Search Endpoint

Call the `semantic_search()` method and pass your search query.

```python
client.semantic_search("Your search query")
```

The above command returns a JSON object.

### Semantic Similarity Endpoint

Call the `semantic_similarity()` method and pass a list made up of 2 blocks of text that you want to compare.

```python
client.semantic_similarity(["<Block of text 1>", "<Block of text 2>"])
```

The above command returns a JSON object.

### Sentence Dependencies Endpoint

Call the `sentence_dependencies()` method and pass a block of text made up of several sentences you want to perform POS + arcs on.

```ruby
client.sentence_dependencies("<Your block of text>")
```

The above command returns a JSON object.

### Sentiment Analysis Endpoint

Call the `sentiment()` method and pass the text you want to analyze the sentiment of:

```ruby
client.sentiment("<Your block of text>")
```

The above command returns a JSON object.

### Speech Synthesis Endpoint

Call the `speech_synthesis()` method and pass the text you want to convert to audio:

```ruby
client.speech_synthesis("<Your block of text>")
```

The above command returns a JSON object.

### Summarization Endpoint

Call the `summarization()` method and pass the text you want to summarize.

```ruby
client.summarization("<Your text to summarize>")
```

The above command returns a JSON object.

### Tokenization Endpoint

Call the `tokens()` method and pass the text you want to tokenize.

```ruby
client.tokens("<Your block of text>")
```

The above command returns a JSON object.

### Translation Endpoint

Call the `translation()` method and pass the text you want to translate.

```ruby
client.translation("<Your text to translate>")
```

The above command returns a JSON object.
