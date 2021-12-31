if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: "#{ENV['REDIS_URL']}"}
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "#{ENV['REDIS_URL']}"}
  end
end

if Rails.env.test? || Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://#{ENV['REDIS_HOST']}:6379/1", namespace: 'staging' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://#{ENV['REDIS_HOST']}:6379/1", namespace: 'staging' }
  end
elsif Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: "#{ENV['REDISTOGO_URL']}", namespace: 'staging' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "#{ENV['REDISTOGO_URL']}", namespace: 'staging' }
  end
end
