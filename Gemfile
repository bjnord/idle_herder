source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'bundler', '1.15.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# jQuery is needed for Bootstrap 3 (e.g. navbar collapse menu button)
# (keeping it out of yarn/node_modules, in the hope of removing it someday)
gem 'jquery-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Tool for generating sitemap
gem 'sitemap_generator'

# Digested image pathnames aren't available in React JS without a bunch
# of work; for now, make non-digested paths available alongside the
# digested ones:
gem 'non-stupid-digest-assets'

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  # these are needed by net-ssh to support ed25519 keys:
  gem 'rbnacl', '~> 4.0.2'  # must be < 5.0
  gem 'rbnacl-libsodium'
  gem 'bcrypt_pbkdf'  # must be < 2.0
end

gem 'foreman'
gem 'webpacker', '~> 3.0.1'
gem 'devise'
gem 'cancancan'

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'guard-rspec', require: false
  gem 'guard-livereload'
  gem 'spring-commands-rspec'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'faker'
end
