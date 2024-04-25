module TestBench
  module Fixtures
    class CompareText
      module Controls
        module Text
          def self.example
            "Some text\nSome more text\nYet more text\n"
          end

          module Difference
            def self.example
              "Some text\nSome MORE text\nYet more text\n"
            end
          end

          module NoDifference
            def self.example
              Text.example
            end
          end

          module Numbered
            def self.example
              "1 |Some text\n2 |Some more text\n3 |Yet more text\n"
            end
          end
        end
      end
    end
  end
end
