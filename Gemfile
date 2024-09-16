source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
#gestione delle autorizzazioni e ruoli
gem 'cancancan'
gem 'rolify'

#gems per l'accesso con provider
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem "omniauth-rails_csrf_protection"
gem 'google_drive'
gem 'googleauth'
gem 'google-api-client', '~> 0.53.0'

gem 'httparty'

#Carriewave per la gestione degli upload, minimagic per la gestione delle immagini
gem 'carrierwave', '~> 3.0'
gem 'mini_magick'

#Devise per la gestione degli utenti
gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.7'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.6.9'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

#Figaro per enviroment variabili
gem 'figaro'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    gem 'rack-mini-profiler', '~> 2.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md

  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1'
end

group :test do
  gem 'cucumber-rails', require: false
  # gem 'database_cleaner'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

   gem 'rspec-rails'
   gem 'rspec-expectations'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'letter_opener_web'
