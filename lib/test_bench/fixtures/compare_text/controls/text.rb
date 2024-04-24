module TestBench
  module Fixtures
    class CompareText
      module Controls
        module Text
          def self.example
            "Some text\nSome more text\nYet more text\n"
          end

          module Different
            def self.example
              "Some text\nSome MORE text\nYet more text\n"
            end
          end
        end
      end
    end
  end
end
