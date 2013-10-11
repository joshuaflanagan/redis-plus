require 'redis/plus'

describe "redis-plus" do
  let(:redis) { Redis.new.tap{|r| r.select 15 } }
  before { redis.flushdb }

  describe "#lgetall" do
    it "retrieves all values in a list" do
      redis.rpush "numbers", "one"
      redis.rpush "numbers", "two"
      redis.rpush "numbers", "three"

      redis.lgetall("numbers").should == ["one", "two", "three"]
    end
  end
end
