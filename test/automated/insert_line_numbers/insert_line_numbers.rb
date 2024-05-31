require_relative '../automated_init'

context "Insert Line Numbers" do
  text = Controls::Text.example
  comment "Text:", text

  insert_line_numbers = CompareText::InsertLineNumbers.new(text)
  numbered_text = insert_line_numbers.()

  comment "Line Numbers Inserted:", numbered_text

  control_text = Controls::Text::Numbered.example
  detail "Control:", control_text

  test do
    assert(numbered_text == control_text)
  end
end
