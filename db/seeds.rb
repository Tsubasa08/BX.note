User.create!(name:  "Example User",
             email: "example@mail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

user = User.create!(name:  "レイルズ@ポストユーザー",
                    email: "post@mail.com",
                    password:              "postpost",
                    password_confirmation: "postpost",
                    admin: true)
content1 =  "アプリケーションを指すblobの永続URLを生成します。アクセス時には、実際のサービスエンドポイントへのリダイレクトが返されます。 このインダイレクションはパブリックURLを実際のURLと切り離し"
content2 = "controller/viewのコンテクスト以外(Background jobs, Cronjobs, etc.)からリンクを作成したい場合、rails_blob_pathに以下の様にアクセス出来ます。"
user.posts.create!(content: content1)
user.posts.create!(content: content2)

%W[HTML CSS  JavaScript jQuery WordPress デザイン Web制作].each { |a| Category.create(name: a) }