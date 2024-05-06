require_relative '../automated_init'

context "Insert Line Numbers" do
  context "Styling" do
    text = Controls::Text.example
    comment "Text:", text

    numbered_text = CompareText::InsertLineNumbers.(text, style: true)
    comment "Line Numbers Inserted:", numbered_text

    control_text = Controls::Text::Numbered::Styled.example
    detail "Control:", control_text

    test do
      assert(numbered_text == control_text)
    end
  end
end
