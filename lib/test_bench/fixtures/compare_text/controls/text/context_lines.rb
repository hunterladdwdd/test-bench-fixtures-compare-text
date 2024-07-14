module TestBench
  module Fixtures
    class CompareText
      module Controls
        module Text
          module ContextLines
            def self.example(lines: nil)
              lines ||= self.lines

              text = ''

              lines.times do |i|
                text << "Line #{i + 1}\n"
              end

              text
            end

            def self.lines
              11
            end

            module Difference
              def self.example(different_text=nil, lines: nil)
                different_text ||= 'Some Difference '

                context_lines_text = ContextLines.example(lines:)

                different_text + context_lines_text
              end
            end
          end
        end
      end
    end
  end
end
