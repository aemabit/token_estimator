# TokenEstimator
TokenEstimator is a Rails gem that provides functionality to count tokens in various file formats and text inputs using different tokenizers.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "token_counter"
```

And then execute:
```bash
bundle install
```

## Methods

#### `count_tokens_from_text`
Count tokens from a given text.

```rb
    require "token_estimator"

    tokenizer_name = "gpt2"
    estimator = TokenEstimator::Estimator.new(tokenizer_name)

    text = "Your sample text here."
    token_estimation = estimator.count_tokens_from_text(text)

    puts "Token estimation: #{token_estimation}"
```

#### `count_tokens_from_file`
Count tokens from a file. The file type is determined by the file extension.

```rb
    require "token_estimator"

    file_path = "spec/fixtures/files/lorem.pdf"
    tokenizer_name = "gpt2"
    estimator = TokenEstimator::Estimator.new(tokenizer_name)

    token_estimation = estimator.count_tokens_from_file(file_path)

    puts "Token estimation: #{token_estimation}"
```

#### `count_tokens_from_excel_file`
Counts tokens from an Excel (.xlsx) file.

#### `count_tokens_from_csv_file`
Counts tokens from a CSV file.

#### `count_tokens_from_pdf_file`
Counts tokens from a PDF file.

#### `count_tokens_from_txt_file`
Counts tokens from a plain text (.txt) file.

#### `count_tokens_from_markdown_file`
Counts tokens from a Markdown (.md) file.

#### `count_tokens_from_json_file`
Counts tokens from a JSON file.

#### `count_tokens_from_html_file`
Counts tokens from an HTML file.

#### `count_tokens_from_json`
Counts tokens from a JSON object.

#### `count_tokens_from_html`
Counts tokens from an HTML string.

## Roadmap
Here is a checklist of the formats we currently support for token counting and those we plan to support in the future:

- [x] PDF
- [x] Markdown (.md)
- [x] CSV
- [x] Excel (XLSX)
- [x] JSON
- [x] Plain Text
- [x] HTML
- [ ] DOCX (Word Documents)
- [ ] XML
- [ ] RTF (Rich Text Format)
- [ ] PNG
- [ ] JPG

## Error Handling
If you try to count tokens from an unsupported file type, the gem will raise an `UnsupportedFileTypeError`

```rb
begin
  token_count = estimator.count_tokens_from_file("path/to/your/file.unsupported")
rescue TokenEstimator::UnsupportedFileTypeError => e
  puts e.message
end
```

## Contributing
Contribution directions go here. You can fork the repository, create a new branch, and submit a pull request for review. Please make sure to write tests for your contributions and follow the coding standards set in the project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
