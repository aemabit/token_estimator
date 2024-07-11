# frozen_string_literal: true

RSpec.describe TokenEstimator do
  let(:fixture_path) { "spec/fixtures/files" }
  let(:token_estimator) { TokenEstimator::Estimator.new("gpt2") }

  it "has a version number" do
    expect(TokenEstimator::VERSION).not_to be nil
  end

  it "should return error with bad tokenizer_name" do
    expect { TokenEstimator::Estimator.new("bad_tokenizer") }.to raise_error(Tokenizers::Error, /Model "bad_tokenizer" on the Hub doesn't have a tokenizer/)
  end

  it "should return number of tokens on read a file excel" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.xlsx")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file csv" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.csv")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file pdf" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.pdf")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file txt" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.txt")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file markdown" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.md")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file json" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.json")
    expect(tokens).to be > 0
  end

  it "should return number of tokens on read a file html" do
    tokens = token_estimator.count_tokens_from_file("#{fixture_path}/lorem.html")
    expect(tokens).to be > 0
  end

  it "should return error for unsupported file type" do
    expect { token_estimator.count_tokens_from_file("#{fixture_path}/unsupported.xyz") }.to raise_error(TokenEstimator::UnsupportedFileTypeError, /File type ".xyz" is not supported/)
  end

  it "should return 0 for an empty string" do
    expect(token_estimator.count_tokens_from_text("")).to eq(0)
  end

  it "should return 1 for a single word" do
    expect(token_estimator.count_tokens_from_text("hello")).to eq(1)
  end

  it "should return correct token count for a multiline text" do
    multiline_text = "Hello world.\nThis is a test."
    expect(token_estimator.count_tokens_from_text(multiline_text)).to eq(9)
  end

  it "should return correct token count for text with special characters" do
    special_char_text = "Hello, world! ¿Cómo estás?"
    expect(token_estimator.count_tokens_from_text(special_char_text)).to eq(12)
  end

  it "should correctly estimate tokens for a large text file" do
    large_text = "Lorem ipsum " * 1000
    expect(token_estimator.count_tokens_from_text(large_text)).to eq(5001)
  end

  it "should handle text with emojis correctly" do
    text_with_emojis = "Hello 😊, this is a test 🎉."
    expect(token_estimator.count_tokens_from_text(text_with_emojis)).to eq(12)
  end

  it "should correctly count tokens in a nested JSON structure" do
    nested_json = '{"key1": "value1", "key2": {"key3": "value3", "key4": {"key5": "value5"}}}'
    tokens = token_estimator.count_tokens_from_json(nested_json)
    expect(tokens).to eq(33)
  end
end
