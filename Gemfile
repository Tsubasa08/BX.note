source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'
gem 'rails',           '~> 5.2.3'
gem 'pg',              '>= 0.18', '< 2.0'
gem 'puma',            '~> 3.11'
gem 'webpacker'
gem "jquery-rails"
gem 'bootsnap', '>= 1.1.0', require: false
gem 'uglifier',        '>= 1.3.0'
gem 'jbuilder',        '~> 2.5'
gem 'bcrypt',          '>= 3.1.12'
gem 'carrierwave',     '>= 1.2.2'
gem 'mini_magick',     '>= 4.7.0'
gem 'fog-aws', '>= 1.42'
gem 'kaminari'
gem 'nokogiri'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '>= 1.0.2'
  gem 'minitest',                 '>= 5.10.3'
  gem 'minitest-reporters',       '>= 1.1.14'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]