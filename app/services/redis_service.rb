class RedisService
  def self.fetch_data(key)
    $redis.hgetall(key)
  end

  # Other Redis-related methods
end