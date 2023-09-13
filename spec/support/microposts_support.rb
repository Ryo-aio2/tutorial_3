module PostSupport
  def create_posts_different_posting_time(test_object: :most_recent)
    FactoryBot.create(:micropost, test_object)
    FactoryBot.create(:micropost, :some_time_ago)
    FactoryBot.create(:micropost, :yesterday)
    FactoryBot.create(:micropost, :last_week)
  end
end

RSpec.configure do |config|
  config.include PostSupport
end
