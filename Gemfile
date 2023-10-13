# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read(File.join(__dir__, '.ruby-version')).strip

gem 'jekyll-theme-chirpy', '~> 6.2'

# Lock jekyll-sass-converter to 2.x on Linux-musl
if RUBY_PLATFORM =~ /linux-musl/
  gem 'jekyll-sass-converter', '~> 2.0'
end
