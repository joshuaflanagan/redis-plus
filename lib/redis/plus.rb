require 'redis'
require "redis/plus/version"

class Redis
  module Plus
    def lgetall(key)
      lrange(key, 0, -1)
    end
  end

  include Plus
end
