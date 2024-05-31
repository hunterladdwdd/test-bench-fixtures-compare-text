require_relative '../automated_init'

context "Insert Line Numbers" do
  text = Controls::Text.example
  comment "Text:", text

  numbered_text = CompareText::InsertLineNumbers.(text, style: false)
  comment "Line Numbers Inserted:", numbered_text

  control_text = Controls::Text::Numbered.example
  detail "Control:", control_text

  test do
    assert(numbered_text == control_text)
  end
end
