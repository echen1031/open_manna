if ENV["REDIS_URL"]
  uri = URI.parse(ENV["REDIS_URL"])
  REDIS = Redis.new(:url => uri)
end
