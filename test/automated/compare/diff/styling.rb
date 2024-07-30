require_relative '../../automated_init'

context "Compare" do
  context "Diff" do
    context "Styling" do
      text = Controls::Text.example
      comment "Text:", text

      different_text = Controls::Text::Difference.example

      diff_output = CompareText::Compare::Diff.(text, different_text)

      comment "Diff Output:", diff_output

      control_diff_output = Controls::CompareOutput::Diff::Styled.example
      detail "Control:", control_diff_output

      test do
        assert(diff_output == control_diff_output)
      end
    end
  end
end
