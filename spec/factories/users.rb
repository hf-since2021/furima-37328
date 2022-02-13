FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    nickname              {gimei.kanji}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6) + "0x"}
    password_confirmation {password}
    last_name             {gimei.last.kanji}
    first_name            {gimei.first.kanji}
    last_name_reading     {gimei.last.katakana}
    first_name_reading    {gimei.first.katakana}
    birth_date            {Faker::Date.between(from: '1930-01-01', to: Date.today)}
  end
end