FactoryBot.define do
  factory :order_residence do
    token                     { 'tok_abcdefghijk00000000000000000' }
    post_code                 { '111-1111' }
    prefecture_id             { Faker::Number.between(from: 2, to: 48) }
    municipality              { '岡山市' }
    house_number              { '倉敷1-1' }
    building_name             { '' }
    phone_number              { '09012345678' }
    item_id                   { '1' }
    user_id                   { '1' }
  end
end
