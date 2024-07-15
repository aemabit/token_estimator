# frozen_string_literal: true

require_relative "token_estimator/version"
require "roo"
require "pdf-reader"
require "tokenizers"
require "csv"
require "kramdown"
require "nokogiri"
require "json"

module TokenEstimator
  class UnsupportedFileTypeError < StandardError; end

  class Estimator
    SUPPORTED_FILE_TYPES = [".txt", ".csv", ".pdf", ".json", ".md", ".html", ".xlsx"]

    def initialize(tokenizer_name)
      @tokenizer = Tokenizers.from_pretrained(tokenizer_name)
    end

    def count_tokens_from_file(file_path)
      extension = File.extname(file_path)
      case extension
      when ".txt"
        count_tokens_from_txt_file(file_path)
      when ".csv"
        count_tokens_from_csv_file(file_path)
      when ".pdf"
        count_tokens_from_pdf_file(file_path)
      when ".json"
        count_tokens_from_json_file(file_path)
      when ".md"
        count_tokens_from_markdown_file(file_path)
      when ".html"
        count_tokens_from_html_file(file_path)
      when ".xlsx"
        count_tokens_from_excel_file(file_path)
      else
        raise UnsupportedFileTypeError, "File type \"#{extension}\" is not supported"
      end
    end

    def count_tokens_from_excel_file(file_path)
      xlsx = Roo::Excelx.new(file_path)
      text = extract_text_from_excel(xlsx)
      count_tokens_from_text(text)
    end

    def count_tokens_from_csv_file(file_path)
      text = extract_text_from_csv(file_path)
      count_tokens_from_text(text)
    end

    def count_tokens_from_pdf_file(file_path)
      reader = PDF::Reader.new(file_path)
      text = extract_text_from_pdf(reader)
      count_tokens_from_text(text)
    end

    def count_tokens_from_txt_file(file_path)
      text = File.read(file_path)
      count_tokens_from_text(text)
    end

    def count_tokens_from_markdown_file(file_path)
      markdown = File.read(file_path)
      html_content = Kramdown::Document.new(markdown).to_html
      count_tokens_from_html(html_content)
    end

    def count_tokens_from_json_file(file_path)
      json_content = File.read(file_path)
      json_data = JSON.parse(json_content)
      count_tokens_from_json(json_data)
    end

    def count_tokens_from_html_file(file_path)
      html_content = File.read(file_path)
      count_tokens_from_html(html_content)
    end

    # util

    def count_tokens_from_json(json_data)
      text = extract_text_from_json(json_data)
      count_tokens_from_text(text)
    end

    def count_tokens_from_html(html_content)
      text = extract_text_from_html(html_content)
      count_tokens_from_text(text)
    end

    def count_tokens_from_text(text)
      tokens = @tokenizer.encode(text).tokens
      tokens.count
    end

    private

    def extract_text_from_excel(xlsx)
      text = ""
      xlsx.each_row_streaming do |row|
        row.each do |cell|
          text += cell.value.to_s + " "
        end
      end
      text.strip
    end

    def extract_text_from_csv(file_path)
      text = ""
      CSV.foreach(file_path) do |row|
        text += row.join(" ") + " "
      end
      text.strip
    end

    def extract_text_from_pdf(reader)
      text = ""
      reader.pages.each do |page|
        text += page.text + " "
      end
      text.strip
    end

    def extract_text_from_html(html)
      Nokogiri::HTML(html).text
    end

    def extract_text_from_json(json_data)
      text = ""
      case json_data
      when Hash
        json_data.each_value { |value| text += extract_text_from_json(value) + " " }
      when Array
        json_data.each { |value| text += extract_text_from_json(value) + " " }
      else
        text += json_data.to_s
      end
      text.strip
    end
  end

end
