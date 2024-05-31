require 'tempfile'

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

Diff Strategies
= = =
TEXT


module WriteTempfiles
  def write_tempfiles(compare_text, control_text)
    compare_path = write_tempfile(compare_text, 'compare')
    control_path = write_tempfile(control_text, 'control')

    [compare_path, control_path]
  end

  def write_tempfile(text, prefix)
    prefix = "#{prefix}-"

    tempfile = Tempfile.new(prefix)
    tempfile.write(text)
    tempfile.close

    tempfile.path
  end
end

module FormatDiff
  def format_diff(diff_output)
    raw_lines = diff_output.each_line.to_a

    lines = raw_lines.drop_while do |line|
      # Remove escape sequences
      line.gsub!(/\e\[(\d+)m/, '')

      !line.start_with?('@@')
    end
    lines.delete_at(0)

    lines.map!.with_index(1) do |line, line_number|
      line_number = line_number.to_s.rjust(4)
      "#{line_number} \e[2m|\e[22m#{line}"
    end

    lines.join
  end
end

module RunCommand
  def run_command(command)
    puts command

    `#{command}`
  end
end

module ContextLines
  def context_lines(compare_text, control_text)
    compare_text_lines = compare_text.lines.count
    control_text_lines = control_text.lines.count

    [compare_text_lines, control_text_lines].max
  end
end

class GitDiff
  include WriteTempfiles
  include FormatDiff
  include RunCommand
  include ContextLines

  def available?
    system('git --version', out: File::NULL)
  end

  def call(compare_text, control_text)
    context_lines = context_lines(compare_text, control_text)

    control_path, compare_path = write_tempfiles(compare_text, control_text)

    diff_command = "git diff --unified=#{context_lines} --color --word-diff #{control_path} #{compare_path}"

    diff_output = run_command(diff_command)

    format_diff(diff_output)
  end
end
test(GitDiff.new)

class Diff
  include WriteTempfiles
  include FormatDiff
  include RunCommand
  include ContextLines

  def available?
    system('diff --version', out: File::NULL)
  end

  def call(compare_text, control_text)
    context_lines = context_lines(compare_text, control_text)

    control_path, compare_path = write_tempfiles(compare_text, control_text)

    diff_command = "diff --color=always --unified=#{context_lines} #{control_path} #{compare_path}"

    diff_output = run_command(diff_command)

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
