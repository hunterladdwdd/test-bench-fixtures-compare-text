module TestBench
  module Fixtures
    class CompareText
      class InsertLineNumbers
        include Initializer

        def style
          @style ||= false
        end
        attr_writer :style

        initializer :text

        def self.build(text, style: nil)
          if style.nil?
            style = Defaults.style
          end

          instance = self.new(text)
          instance.style = style
          instance
        end

        def self.call(text, style: nil)
          instance = build(text, style: style)
          instance.()
        end

        def call
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
