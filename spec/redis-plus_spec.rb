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
      redis.lstrlen("numbers", -1).should == 5
    end

    it "returns 0 when the index is out of range" do
      redis.lstrlen("numbers", 10).should == 0
      redis.lstrlen("numbers", -10).should == 0
    end

    it "raises a 'wrong kind of value' error when not used on a list" do
      redis.set "stringval", "hello"

      expect { redis.lstrlen("stringval", 0) }.to raise_error {|error|
        error.should be_a Redis::CommandError
        error.message.should  match /wrong kind of value/
        error.message.should_not  match /running script/
      }
    end
  end

  describe "#lstrrange" do
    it "retrieves a substring of a string value stored in a list" do
      redis.rpush "words", "apple"
      redis.rpush "words", "orange"
      redis.rpush "words", "pineapple"

      redis.lstrrange("words", 1, 2, 4).should == "ang"
      redis.lstrrange("words", 2, 4, 100).should == "apple"
      redis.lstrrange("words", 2, -5, -3).should == "app"
      redis.lstrrange("words", 1, -100, 1).should == "or"
    end

    it "returns an empty string when the index is out of range" do
      redis.rpush "words", "apple"

      redis.lstrrange("words", 99, 1, 2).should == ""
    end

    it "raises a 'wrong kind of value' error when not used on a list" do
      redis.set "stringval", "hello"

      expect { redis.lstrrange("stringval", 0, 0, 1) }.to raise_error {|error|
        error.should be_a Redis::CommandError
        error.message.should  match /wrong kind of value/
        error.message.should_not  match /running script/
      }
    end
  end

  describe "#jsonget" do
    it "retrieves a value by key from a json encoded string" do
      redis.set "info", '{"day": 25, "month": "October", "year": 2013}'

      redis.jsonget("info", "month").should == "October"
    end

    it "returns nil when the field does not exist" do
      redis.set "info", '{"day": 25, "month": "October", "year": 2013}'

      redis.jsonget("info", "century").should be_nil
    end

    it "raises a 'wrong kind of value' error when not used on a string" do
      redis.rpush "numbers", '{"day": 25, "month": "October", "year": 2013}'

      expect { redis.jsonget("numbers", "month") }.to raise_error {|error|
        error.should be_a Redis::CommandError
        error.message.should  match /wrong kind of value/
        error.message.should_not  match /running script/
      }
    end
  end
end
