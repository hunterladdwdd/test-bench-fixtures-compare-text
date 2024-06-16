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
          end
        end
      end
    end
  end
end
