module TestBench
  module Fixtures
    class CompareText
      module Compare
        class GitDiff
          include Initializer

          initializer :text, :different_text

          def call
            control_text_path = write_tempfile(text, 'control')
            compare_text_path = write_tempfile(different_text, 'compare')

            puts control_text_path.inspect
            puts compare_text_path.inspect
            ''
          end

          def write_tempfile(text, prefix)
            prefix = "#{prefix}-"

            tempfile = Tempfile.new(prefix)
            tempfile.write(text)
            tempfile.close

            tempfile.path
          end
        end
      end
    end
  end
end
