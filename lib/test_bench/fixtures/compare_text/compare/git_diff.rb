module TestBench
  module Fixtures
    class CompareText
      module Compare
        class GitDiff
          include Initializer

          initializer :text, :different_text

          def call
            control_path = write_tempfile(text, 'control')
            compare_path = write_tempfile(different_text, 'compare')

            ## Replace static value 111 with value appropriate for input texts
            diff_command = "git diff --unified=111 --color --word-diff #{control_path} #{compare_path}"

            diff_output = run_command(diff_command)

            formatted_diff = format_diff(diff_output)

            formatted_diff
          end

          def write_tempfile(text, prefix)
            prefix = "#{prefix}-"

            tempfile = Tempfile.new(prefix)
            tempfile.write(text)
            tempfile.close

            tempfile.path
          end

          def run_command(command)
            `#{command}`
          end

          def format_diff(diff_output)
            raw_lines = diff_output.each_line.to_a

            lines = raw_lines.drop_while do |line|
              line.gsub!(/\e\[(\d+)m/, '')

              !line.start_with?('@@')
            end

            lines.delete_at(0)

            lines.join
          end
        end
      end
    end
  end
end
