FactoryBot.define do
  factory :article do
    name { '封筒' }
  end

  factory :stock do
    quantity { 20 }
    minimum_stock_level { 10 }
    association :article
  end
end