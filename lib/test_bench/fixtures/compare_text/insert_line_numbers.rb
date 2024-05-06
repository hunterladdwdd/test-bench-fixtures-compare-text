module TestBench
  module Fixtures
    class CompareText
      module InsertLineNumbers
        def self.call(text, style: nil)
          numbered_text = String.new

          text_lines = text.lines

          line_count = text_lines.count
          line_number_width = line_count.to_s.length

          text_lines.each_with_index do |line, index|
            line_number = index + 1
            justified_line_number = line_number.to_s.rjust(line_number_width)

            if style
              numbered_text << "\e[2m#{justified_line_number}\u00b7\e[22m#{line}"
            else
              numbered_text << "#{justified_line_number} #{line}"
            end
          end

          numbered_text
        end
      end
    end
  end
end
