module TestBench
  module Fixtures
    class CompareText
      module InsertLineNumbers
        def self.call(text)
          numbered_text = String.new

          text.lines.each_with_index do |line, index|
            line_number = index + 1
            numbered_text << "#{line_number} |#{line}"
          end

          numbered_text
        end
      end
    end
  end
end
