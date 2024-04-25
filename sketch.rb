require_relative 'test/test_init'

class CompareText
  include TestBench::Fixture

  attr_reader :compare_text
  attr_reader :control_text

  def initialize(compare_text, control_text)
    @compare_text = compare_text
    @control_text = control_text
  end

  def call
    context "Compare Text" do
      compare_path, control_path = write_tempfiles(compare_text, control_text)

      diff_command = "git diff --unified=111 --color --word-diff #{control_path} #{compare_path}"

      diff_output = run_command(diff_command)

      formatted_diff = format_diff(diff_output)

      if formatted_diff.empty?
        numbered_text = apply_numbering(compare_text)
        detail numbered_text
      else
        detail formatted_diff
      end

      test do
        assert(compare_text == control_text)
      end
    end
  end

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

  def run_command(command)
    `#{command}`
  end

  def format_diff(diff_output)
    raw_lines = diff_output.each_line.to_a

    lines = raw_lines.drop_while do |line|
      # Remove escape sequences
      line.gsub!(/\e\[(\d+)m/, '')

      !line.start_with?('@@')
    end
    lines.delete_at(0)

    text = lines.join
    apply_numbering(text)
  end

  def apply_numbering(text)
    lines = text.each_line.to_a
    number_of_lines = lines.length
    line_number_width = number_of_lines.to_s.length

    lines.map!.with_index(1) do |line, line_number|
      line_number = line_number.to_s.rjust(line_number_width)
      "#{line_number} \e[2m|\e[22m#{line}"
    end

    lines.join
  end
end

context "Compare Text Example" do
  control_text = Controls::Text.example

  context "No Difference" do
    compare_text = Controls::Text::NoDifference.example

    fixture(CompareText, compare_text, control_text)
  end

  context "Difference" do
    compare_text = Controls::Text::Difference.example

    fixture(CompareText, compare_text, control_text)
  end
end
