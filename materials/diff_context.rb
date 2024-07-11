require 'tempfile'
require_relative '../test/test_init'

def write_tempfile(text, prefix)
  prefix = "#{prefix}-"

  tempfile = Tempfile.new(prefix)
  tempfile.write(text)
  tempfile.close

  tempfile.path
end

text = Controls::Text::ContextLines.example

different_text = Controls::Text::ContextLines::Difference.example

compare_path = write_tempfile(text, 'compare')
control_path = write_tempfile(different_text, 'control')

number = (2 ** 31) - 1

diff_command = "git diff --unified=#{number} --color --word-diff #{control_path} #{compare_path}"
puts diff_command

diff_output = `#{diff_command}`

puts diff_output
