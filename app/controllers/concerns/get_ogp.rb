module GetOgp
  extend ActiveSupport::Concern

  def get_ogp
    url = @post.link_url
    begin
      # リンク先OGP取得
      $doc = Nokogiri::HTML(open(url)) # エラーポイント
      $link_title = $doc.css('meta[property="og:title"]').attribute('content').to_s
      $link_image = $doc.css('meta[property="og:image"]').attribute('content').to_s
      $link_desc = $doc.css('meta[property="og:description"]').attribute('content').to_s
      if $link_title && $link_image && $link_desc # エラーポイントを通れば各metaタグのcontentが空でもtrue
        @post.link_title = $link_title
        @post.link_image = $link_image
        @post.link_desc = $link_desc
        if @post.save
          respond_to do |format|
            format.html { redirect_back(fallback_location: root_url) }
            format.js
          end
        end
      end
    rescue StandardError # エラーが発生した場合(正規表現だが存在しないURL)
      @post.destroy if action_name == 'create'
      @e_error = '記事のURLが存在しません。'
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end
end
