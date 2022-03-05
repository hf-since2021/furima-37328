FactoryBot.define do
  factory :order_address do
    postal_code            { Faker::Base.numerify '###-####' }
    prefecture_id          { Faker::Number.between(from: 2, to: 48) }
    city                   { Faker::Address.city }
    house_number           { Faker::Address.street_name }
    building_name          { Faker::Address.secondary_address }
    phone_number           { Faker::Number.number(digits: 11) }
    token                  { 'tok_abcdefghijk00000000000000000' }
  end
end
