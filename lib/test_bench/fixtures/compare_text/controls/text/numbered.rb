module TestBench
  module Fixtures
    class CompareText
      module Controls
        module Text
          module Numbered
            def self.example
              "1 Some text\n2 Some more text\n3 Yet more text\n"
            end

            module Styled
              def self.example
                "\e[2m1\u00b7\e[22mSome text\n\e[2m2\u00b7\e[22mSome more text\n\e[2m3\u00b7\e[22mYet more text\n"
              end
            end
          end
        end
      end
    end
  end
end
