module TestBench
  module Fixtures
    class CompareText
      module Controls
        module CompareOutput
          module Diff
            def self.example
              <<~TEXT
               Some text
              -Some more text
              +Some MORE text
               Yet more text
              TEXT
            end

            module Styled
              def self.example
                <<~TEXT
                 Some text
                \e[31m-Some more text
                \e[m\e[32m+Some MORE text
                \e[m Yet more text
                TEXT
              end
            end
            #
            # module ContextLines
            #   def self.example(lines: nil)
            #     different_text = '{+Some Difference+} '
            #
            #     Controls::Text::ContextLines::Difference.example(different_text, lines:)
            #   end
            # end
          end
        end
      end
    end
  end
end
