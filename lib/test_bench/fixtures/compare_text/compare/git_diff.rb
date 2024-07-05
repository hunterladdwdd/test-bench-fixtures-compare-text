module TestBench
  module Fixtures
    class CompareText
      module Compare
        class GitDiff
          include Initializer

          def style
            @style ||= false
          end
          attr_writer :style

          initializer :text, :different_text

          def self.build(text, different_text, style: nil)
            if style.nil?
              style = Defaults.style
            end

            instance = self.new(text, different_text)
            instance.style = style
            instance
          end

          def self.call(text, different_text, style: nil)
            instance = build(text, different_text, style: style)
            instance.()
          end

          def call
            control_path = write_tempfile(text, 'control')
            compare_path = write_tempfile(different_text, 'compare')

            # text_line_count = text.lines.count
            # different_line_count = different_text.lines.count
            # line_count = [text_line_count, different_line_count].max

            ## Replace static value 111 with value appropriate for input texts
            if style
              diff_command = "git diff --unified=111 --color --word-diff #{control_path} #{compare_path}"
            else
              diff_command = "git diff --unified=111 --word-diff #{control_path} #{compare_path}"
            end

            raw_diff_output = run_command(diff_command)

            diff_output = format_diff(raw_diff_output)
            diff_output
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
