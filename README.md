# ActivePgLog

ActivePgLog will record all changes made to the class either using ActiveRecord or in the database itself. Generating a new tuple in the log table and ensuring traceability.

The ActivePgLog gem was conceived with the idea of ​​being a simple but flexible log.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_pg_log'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_pg_log

## Usage

After performing the previous steps. Go into your project's root directory and type `rails g active_pg_log:install` or `rails g active_pg_log:uninstall` to remove the settings.

After executing the above command. Just add the ActivePgLog::ActiveLog module to your class. Example:

    class Person
        include ActivePgLog::ActiveLog
        attr_accessor :name, :phone
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/waejl/active_pg_log. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActivePgLog project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/waejl/active_pg_log/blob/master/CODE_OF_CONDUCT.md).
