require_relative '../../automated_init'

context "Compare" do
  context "Git Diff" do
    context "Styling" do
      text = Controls::Text.example
      comment "Text:", text

      different_text = Controls::Text::Difference.example

      diff_output = CompareText::Compare::GitDiff.(text, different_text, style: true)

      comment "Diff Output:", diff_output

      control_diff_output = Controls::CompareOutput::GitDiff::Styled.example
      detail "Control:", control_diff_output

      test do
        assert(diff_output == control_diff_output)
      end
    end
  end
end
