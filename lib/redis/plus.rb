require 'redis'
require "redis/plus/version"

class Redis
  module Plus
    def lgetall(key)
      lrange(key, 0, -1)
    end

    def lstrlen(key, index)
      self.eval "return string.len(redis.call('lrange',KEYS[1],ARGV[1],ARGV[1])[1])", [key], [index]
    end
  end

  include Plus
end
