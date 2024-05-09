FactoryBot.define do
  factory :user do
    nickname              { 'toshi' }
    email                 { Faker::Internet.email }
    password              { 'T77777' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    read_last_name        { 'ヤマダ' }
    read_first_name       { 'タロウ' }
    birthday              { '2022/2/2' }
  end
end
