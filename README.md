# Pathname

Pathname represents the name of a file or directory on the filesystem,
but not the file itself.

The pathname depends on the Operating System: Unix, Windows, etc.
This library works with pathnames of local OS, however non-Unix pathnames
are supported experimentally.

A Pathname can be relative or absolute.  It's not until you try to
reference the file that it even matters whether the file exists or not.

Pathname is immutable.  It has no method for destructive update.

The goal of this class is to manipulate file path information in a neater
way than standard Ruby provides.  The examples below demonstrate the
difference.

*All* functionality from File, FileTest, and some from Dir and FileUtils is
included, in an unsurprising way.  It is essentially a facade for all of
these, and more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pathname'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pathname

## Usage

```ruby
require 'pathname'
pn = Pathname.new("/usr/bin/ruby")
size = pn.size              # 27662
isdir = pn.directory?       # false
dir  = pn.dirname           # Pathname:/usr/bin
base = pn.basename          # Pathname:ruby
dir, base = pn.split        # [Pathname:/usr/bin, Pathname:ruby]
data = pn.read
pn.open { |f| _ }
pn.each_line { |line| _ }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to compile this and run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby/pathname.
