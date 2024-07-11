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

            module ContextLines
              def self.example
                <<~TEXT
                {+Some Difference+} Line 1
                Line 2
                Line 3
                Line 4
                Line 5
                Line 6
                Line 7
                Line 8
                Line 9
                Line 10
                Line 11
                TEXT
              end
            end
          end
        end
      end
    end
  end
end
