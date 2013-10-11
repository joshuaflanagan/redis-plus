# Redis::Plus

Extends the [ruby redis client](https://github.com/redis/redis-rb)
with additional general purpose commands.

Requires [Redis 2.6+](http://redis.io)

## Installation

Add this line to your application's Gemfile:

    gem 'redis-plus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-plus

## Usage

The new commands are available directly from any `Redis` connection instance:

```ruby
r = Redis.new
r.rpush "numbers", "one"
r.rpush "numbers", "two"
r.rpush "numbers", "three"

# retrieve all elements of a list:
r.lgetall "numbers"         #=> ["one", "two", "three"]

# retrieve the length of a string value stored in a list
r.lstrlen "numbers", 0      #=> 3
r.lstrlen "numbers", 2      #=> 5

# retrieve a substring of a string value stored in a list
r.lstrrange "numbers", 2, 1, 3 #=> "hre"
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
