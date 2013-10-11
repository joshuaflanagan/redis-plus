require 'redis'
require "redis/plus/version"

class Redis
  module Plus
    def lgetall(key)
      lrange(key, 0, -1)
    end

    def lstrlen(key, index)
      command = <<-LUA
local v = redis.pcall('lrange',KEYS[1],ARGV[1],ARGV[1])
if v.err then
  return v
else
  return v[1] and string.len(v[1])
end
LUA
      self.eval(command, [key], [index]) || 0
    end
  end

  include Plus
end
