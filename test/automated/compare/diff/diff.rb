require_relative '../../automated_init'

context "Compare" do
  context "Diff" do
    text = Controls::Text.example
    comment "Text:", text

    different_text = Controls::Text::Difference.example

    diff = CompareText::Compare::Diff.new(text, different_text)
    diff_output = diff.()

    comment "Diff Output:", diff_output

    control_diff_output = Controls::CompareOutput::Diff.example
    detail "Control:", control_diff_output

    test do
      assert(diff_output == control_diff_output)
    end
  end
end
