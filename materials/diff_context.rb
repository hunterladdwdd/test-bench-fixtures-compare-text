require 'tempfile'
require './test/test_init'

def write_tempfile(text, prefix)
  prefix = "#{prefix}-"

  tempfile = Tempfile.new(prefix)
  tempfile.write(text)
  tempfile.close

  tempfile.path
end

text = 'text'

100.times do |i|
  text << "Line #{i + 1}\n"
end

different_text = ''

100.times do |i|
  different_text << "Line #{i + 1}\n"
end

compare_path = write_tempfile(text, 'compare')
control_path = write_tempfile(different_text, 'control')

number = (2 ** 31) - 1

diff_command = "git diff --unified=#{number} --color --word-diff #{control_path} #{compare_path}"
puts diff_command

diff_output = `#{diff_command}`

puts diff_output
