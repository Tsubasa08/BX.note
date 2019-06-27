User.create!(name:  "Example User",
             email: "example@mail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)


%W[HTML CSS  JavaScript jQuery WordPress デザイン Web制作].each { |a| Category.create(name: a) }