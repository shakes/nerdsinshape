File.open("#{RAILS_ROOT}/.twitter_account_info") do |f|
    TWITTER_USERNAME = f.gets.strip
    TWITTER_PASSWORD = f.gets.strip
end
