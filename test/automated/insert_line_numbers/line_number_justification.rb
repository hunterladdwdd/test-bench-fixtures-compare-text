require_relative '../automated_init'

context "Insert Line Numbers" do
  context "Line Number Justification" do
    text = <<~TEXT
    Line 1
    Line 2
    Line 3
    Line 4
    Line 5
    Line 6
    Line 7
    Line 8
    Line 9
    Line 10
    TEXT

    instance = CompareText::InsertLineNumbers.new(text)
    numbered_text = instance.()

    comment "Line Numbers Inserted:", numbered_text

    test do
      assert(numbered_text.start_with?(' 1'))
    end
  end
end
