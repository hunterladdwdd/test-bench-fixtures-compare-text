require_relative 'automated_init'

context "Insert Line Numbers" do
  text = Controls::Text.example
  detail "Text:", text

  numbered_text = CompareText::InsertLineNumbers.(text)
  comment "Numbered Text:", numbered_text

  control_text = Controls::Text::Numbered.example
  detail "Control:", control_text

  test do
    assert(numbered_text == control_text)
  end
end
