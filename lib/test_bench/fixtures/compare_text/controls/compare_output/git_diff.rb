module TestBench
  module Fixtures
    class CompareText
      module Controls
        module CompareOutput
          module GitDiff
            def self.example
              <<~TEXT
              Some text
              Some [-more-]{+MORE+} text
              Yet more text
              TEXT
            end

            module Styled
              def self.example
                <<~TEXT
                Some text\e[m
                Some \e[31m[-more-]\e[m\e[32m{+MORE+}\e[m text
                Yet more text\e[m
                TEXT
              end
            end
          end
        end
      end
    end
  end
end
