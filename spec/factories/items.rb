FactoryBot.define do
  factory :item do
    item_name                 { 'オムライス' }
    item_description          { '美味しいです' }
    item_category_id          { Faker::Number.between(from: 2, to: 11) }
    item_condition_id         { Faker::Number.between(from: 2, to: 7) }
    prefecture_id             { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id           { Faker::Number.between(from: 2, to: 4) }
    shipping_fee_id           { Faker::Number.between(from: 2, to: 3) }
    item_price                { 500 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
