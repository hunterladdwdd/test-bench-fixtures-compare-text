require_relative '../../automated_init'

context "Compare" do
  context "Git Diff" do
    context "Context Lines" do
      text = Controls::Text::ContextLines.example

      different_text = Controls::Text::ContextLines::Difference.example

      git_diff = CompareText::Compare::GitDiff.new(text, different_text)
      diff_output = git_diff.()

      comment "Diff Output:", diff_output

      control_diff_output = Controls::CompareOutput::GitDiff::ContextLines.example
      detail "Control:", control_diff_output

      test do
        assert(diff_output == control_diff_output)
      end
    end
  end
end
