require 'tempfile'

## To Do
# - git diff and diff must print out the entire document
# - Review git diff and diff documentation and consider all arguments
# - Review Ruby's ShellWords documentation and identify way to demonstrate the problem it solves

def test(diff)
  puts <<~TEXT

  #{diff.class}
  - - -
  TEXT

  control_text = String.new
  compare_text = String.new

  (1..10).each do |index|
    control_fragment = <<~XML
    <some-tag-#{index} some-attr="some value #{index}">
      <some-inner-tag/>
    </some-tag-#{index}>
    XML

    if index == 5
      compare_fragment = <<~XML
      <some-tag-#{index} some-attr="some other value #{index}">
        <some-other-inner-tag/>
      </some-tag-#{index}>
      XML
    else
      compare_fragment = control_fragment
    end

    control_text << control_fragment
    compare_text << compare_fragment
  end

  if diff.available?
    puts "\e[1;4mExample output:\e[24;22m"

    puts diff.(compare_text, control_text)
  else
    puts "Not available"
  end
end


puts <<~TEXT

Sketch
= = =
TEXT


module WriteTempfile
  def write_tempfile(text)
    tempfile = Tempfile.new
    tempfile.write(text)
    tempfile.close

    tempfile.path
  end
end

module FormatDiff
  def format_diff(diff_output)
    lines = diff_output.each_line.to_a

    lines = lines.drop_while do |line|
      # Remove escape sequences
      line = line.gsub(/\e\[(\d+)m/, '')

      !line.start_with?('@@')
    end

    lines = lines[1..]

    lines.join
  end
end

class GitDiff
  include WriteTempfile
  include FormatDiff

  def available?
    system('git --version', out: File::NULL)
  end

  def call(compare_text, control_text)
    compare_path = write_tempfile(compare_text)
    control_path = write_tempfile(control_text)

    diff_output = `git diff --color --word-diff #{control_path} #{compare_path}`

    format_diff(diff_output)
  end
end
test(GitDiff.new)

class Diff
  include WriteTempfile
  include FormatDiff

  def available?
    system('diff --version', out: File::NULL)
  end

  def call(compare_text, control_text)
    compare_path = write_tempfile(compare_text)
    control_path = write_tempfile(control_text)

    diff_output = `diff --color=always --unified #{control_path} #{compare_path}`

    format_diff(diff_output)
  end
end
test(Diff.new)

class SomeOtherDiff
  def available?
    system('some-unknown-command')
  end

  def call(_compare_text, _control_text)
    abort "Shouldn't reach here"
  end
end
test(SomeOtherDiff.new)

puts
