source 'https://rubygems.org'
ruby '2.7.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.2.4'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem "serviceworker-rails"
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'aws-sdk-s3', require: false

group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :production do
  gem 'pg', '1.1.4'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
