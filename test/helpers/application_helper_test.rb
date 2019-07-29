require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'ページごとのタイトル設定' do
    assert_equal full_title, 'BX.note'
    assert_equal full_title('BX.noteとは？'), 'BX.noteとは？ | BX.note'
  end
end
