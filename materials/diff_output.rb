require 'tempfile'
require_relative '../test/test_init'

def write_tempfile(text, prefix)
  prefix = "#{prefix}-"

  tempfile = Tempfile.new(prefix)
  tempfile.write(text)
  tempfile.close

  tempfile.path
end

text = Controls::Text.example

different_text = Controls::Text::Difference.example

compare_path = write_tempfile(text, 'compare')
control_path = write_tempfile(different_text, 'control')

number = (2 ** 31) - 1

diff_command = "diff --unified=#{number} #{compare_path} #{control_path}"
puts diff_command

diff_output = `#{diff_command}`

puts diff_output
