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

  describe "#lstrlen" do
    it "retrieves the length of a string value stored in a list" do
      redis.rpush "numbers", "one"
      redis.rpush "numbers", "two"
      redis.rpush "numbers", "three"

      redis.lstrlen("numbers", 0).should == 3
      redis.lstrlen("numbers", 1).should == 3
      redis.lstrlen("numbers", 2).should == 5
    end
  end
end
