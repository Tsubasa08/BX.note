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
  # def get_host(path)
  #   host = path.sub(/\\/, '/').match(/\/\/([^\/]*)/)
  #   host[1]
  # end

  def get_host(path)
  require 'uri'
  uri = URI.parse(path)
  uri.host
end

  # 記事のOGP取得
  # def get_ogp(url, data)
  #   require 'nokogiri'
  #   require 'open-uri'
  #   $doc = Nokogiri::HTML(open(url))
  #   $data = data

  #   if data = "title"
  #     ogp = $doc.css('meta[property="og:title"]').attribute('content').to_s
  #   elsif data = "image"
  #     ogp = $doc.css('meta[property="og:image"]').attribute('content').to_s
  #   elsif data = "desc"
  #     ogp = $doc.css('meta[property="og:description"]').attribute('content').to_s
  #   end
  #   ogp
  # end

end
