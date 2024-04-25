require_relative 'automated_init'

context "Insert Line Numbers" do
  text = Controls::Text.example

  numbered_text = CompareText::InsertLineNumbers.(text)

  test do
    assert(numbered_text == Controls::Text::Numbered.example)
  end
end
