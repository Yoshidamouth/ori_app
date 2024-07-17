FactoryBot.define do
  factory :request do
    article_id { 2 }
    quantity { 10 }
    status { '未対応' }
    request_time { Time.now }
    association :user
  end
end
