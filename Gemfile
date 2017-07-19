source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.3'
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'fog-aws'
gem 'sdoc',                    '0.4.0', group: :doc
gem 'bcrypt',                  '3.1.10'
gem 'faker',                   '1.4.2'
gem 'carrierwave'
gem 'remotipart'
gem 'geocoder'
gem 'gon'
gem 'paperclip', git: "git://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '~> 2.3'
gem 'lodash-rails'
gem 'puma'
gem 'font-awesome-rails'
# passwords
gem 'figaro'
# photo uploading and manipulation
gem 'rmagick', '~> 2.13.1'
gem 'mini_magick'
# for sending email
gem 'sendgrid-ruby'
# authentication
gem 'devise'
gem 'omniauth-facebook'
gem 'mailboxer'
gem 'chosen-rails'

group :development, :test do
  gem 'better_errors'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Needed for heroku
gem 'rails_12factor', group: :production
ruby '2.3.1'
