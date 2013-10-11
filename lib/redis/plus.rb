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

    def lstrrange(key, index, startpos, endpos)
      command = <<-LUA
local v = redis.pcall('lrange',KEYS[1],ARGV[1],ARGV[1])
if v.err then
  return v
else
  local start = tonumber(ARGV[2])
  local stop = tonumber(ARGV[3])
  if start >= 0 then start = start + 1 end
  if stop >= 0 then stop = stop + 1 end
  return v[1] and string.sub(v[1], start, stop)
end
LUA
      self.eval(command, [key], [index, startpos, endpos]) || ""
    end
  end

  include Plus
end
