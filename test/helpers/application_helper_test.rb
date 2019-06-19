require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title, "BX.note"
    assert_equal full_title("BX.noteとは？"), "BX.noteとは？ | BX.note"
  end
end