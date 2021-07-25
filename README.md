# Ruby Client For NLP Cloud

This is a Ruby client for the NLP Cloud API: https://docs.nlpcloud.io

NLP Cloud serves high performance pre-trained for NER, sentiment-analysis, classification, summarization, text generation, question answering, machine translation, language detection, tokenization, POS tagging, and dependency parsing. It is ready for production, served through a REST API.

Pre-trained models are the spaCy models and some transformers-based models from Hugging Face. You can also deploy your own transformers-based models or spaCy models.

If you face an issue, don't hesitate to raise it as a Github issue. Thanks!

## Installation

Install via gem.

```shell
gem install nlpcloud
```

## Examples

Here is a full example that performs Named Entity Recognition (NER) using spaCy's `en_core_web_lg` model, with a fake token:

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new('en_core_web_lg','4eC39HqLyjWDarjtT1zdp7dc')
client.entities("John Doe is a Go Developer at Google")
```

And a full example that uses your own custom model `7894`:

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new('custom_model/7894','4eC39HqLyjWDarjtT1zdp7dc')
client.entities("John Doe is a Go Developer at Google")
```

A json object is returned. Here is what it could look like:

```json
[
  {
    "end": 8,
    "start": 0,
    "text": "John Doe",
    "type": "PERSON"
  },
  {
    "end": 25,
    "start": 13,
    "text": "Go Developer",
    "type": "POSITION"
  },
  {
    "end": 35,
    "start": 30,
    "text": "Google",
    "type": "ORG"
  },
]
```

## Usage

### Client Initialization

Pass the model you want to use and the NLP Cloud token to the client during initialization.

The model can either be a pre-trained model like `en_core_web_lg`, `bart-large-mnli`... but also one of your custom transformers-based models, or spaCy models, using `custom_model/<model id>` (e.g. `custom_model/2568`).

Your token can be retrieved from your [NLP Cloud dashboard](https://nlpcloud.io/home/token).

```ruby
require 'nlpcloud'

client = NLPCloud::Client.new("<model>", "<your token>")
```

If you want to use a GPU, pass `gpu: true`.

```ruby
require 'nlpcloud'

client = nlpcloud.Client("<model>", "<your token>", gpu: true)

### Entities Endpoint

Call the `entities()` method and pass the text you want to perform named entity recognition (NER) on.

```ruby
client.entities("<Your block of text>")
```

The above command returns a JSON object.

### Classification Endpoint

Call the `classification()` method and pass 3 arguments:

1. The text you want to classify, as a string
1. The candidate labels for your text, as a list of strings
1. Whether the classification should be multi-class or not, as a boolean

```ruby
client.classification("<Your block of text>", ["label 1", "label 2", "..."], true|false)
```

The above command returns a JSON object.

### Sentiment Analysis Endpoint

Call the `sentiment()` method and pass the text you want to analyze the sentiment of:

```ruby
client.sentiment("<Your block of text>")
```

The above command returns a JSON object.

### Question Answering Endpoint

Call the `question()` method and pass the following:

1. A context that the model will use to try to answer your question
1. Your question

```ruby
client.question("<Your context>", "<Your question>")
```

The above command returns a JSON object.

### Summarization Endpoint

Call the `summarization()` method and pass the text you want to summarize.

**Note that your block of text should not exceed 1024 words, otherwise you will get an error. Also note that this model works best for blocks of text between 56 and 142 words.**

```ruby
client.summarization("<Your text to summarize>")
```

The above command returns a JSON object.

### Translation Endpoint

Call the `translation()` method and pass the text you want to translate.

```ruby
client.translation("<Your text to translate>")
```

The above command returns a JSON object.

### Dependencies Endpoint

Call the `dependencies()` method and pass the text you want to perform part of speech tagging (POS) + arcs on.

```ruby
client.dependencies("<Your block of text>")
```

The above command returns a JSON object.

### Sentence Dependencies Endpoint

Call the `sentence_dependencies()` method and pass a block of text made up of several sentencies you want to perform POS + arcs on.

```ruby
client.sentence_dependencies("<Your block of text>")
```

The above command returns a JSON object.

### Library Versions Endpoint

Call the `lib_versions()` method to know the versions of the libraries used behind the hood with the model (for example the PyTorch, TensorFlow or spaCy versions used).

```ruby
client.lib_versions()
```

The above command returns a JSON object.

