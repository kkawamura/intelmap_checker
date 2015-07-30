# IntelmapChecker

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/intelmap_checker`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is simple tool for INGRESS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'intelmap_checker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install intelmap_checker

## Setup
You should set-up selenium-webdriver and chrome driver.
* http://www.rubydoc.info/gems/selenium-webdriver/
* https://code.google.com/p/selenium/wiki/ChromeDriver

## Usage

```ruby
require 'intelmap_checker'

ntelmap = IntelmapChecker.new( YOUR_GOOGLE_EMAIL, YOUR_GOOGLE_PASSWORD)
intelmap.load_map(INTELMAP_PERMANENT_LINK)

all_comments = intelmap.all_comments
faction_comments = intelmap.faction_comments
portal_details = intelmap.portal_details
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kkawamura/intelmap_checker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

