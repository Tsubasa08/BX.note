module ApplicationHelper

  # ページごとのタイトル設定
  def full_title(page_title = "")
    base_title = "BX.note"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # ホスト名取得
  def get_host(path)
  require 'uri'
  uri = URI.parse(path)
  uri.host
end

end
