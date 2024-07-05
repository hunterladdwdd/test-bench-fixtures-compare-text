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

          module Sequence
            def self.example(lines=nil)
              lines ||= 1

              text = String.new

              lines.times do |i|
                text << "Line #{i + 1}\n"
              end

              text
            end

            module Difference
              def self.example(lines=nil)
                text = Sequence.example(lines)
                text.insert(0, 'a different line')
                text
              end
            end
          end
        end
      end
    end
  end
end
