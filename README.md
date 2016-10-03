# Fileflock

A straight forward Ruby 2 library that will allow users to wrap code execution via a block using `File.flock` exclusive file lock. 

## Installation

## Note! This gem has not been published to [rubygems.org](https://rubygems.org) (yet)

Add this line to your application's Gemfile:

```ruby
gem 'fileflock'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fileflock

## Usage

```ruby
Fileflock '/tmp/file.lock' do
  # Execute code with exclusive lock via flock here...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nbolser/fileflock.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

