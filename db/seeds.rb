User.create!(name:  "kaerukun@test",
             email: "kaeru@mail.com",
             password:              "password",
             password_confirmation: "password",
             introduce: "テストユーザーです。よろしくお願いします。")


%W[HTML CSS  JavaScript jQuery WordPress デザイン Web制作].each { |a| Category.create(name: a) }