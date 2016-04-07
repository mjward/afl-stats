module Scrapers
  class InputSanitizer

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def execute
      if data.is_a?(Array)
        sanitized_data = data.map { |e| clean_input(e) }.reject(&:empty?)
      else
        sanitized_data = clean_input(data)
      end
      sanitized_data.nil? || sanitized_data.empty? ? nil : sanitized_data
    end

    private

    def clean_input(string)
      string.gsub(non_breaking_space, "").gsub(/\A[[:space:]]+|[[:space:]]+\z/, '').strip
    end

    def non_breaking_space
      Nokogiri::HTML("&#xA0;").text
    end
  end
end
