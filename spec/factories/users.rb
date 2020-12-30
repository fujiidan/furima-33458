FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.unique.name }
    end

    nickname { person }
    first_name               { person.first.kanji }
    last_name                { person.last.kanji }
    first_name_kana          { person.first.katakana }
    last_name_kana           { person.last.katakana }
    email                    { Faker::Internet.free_email }
    password                 { "1a#{Faker::Internet.password(min_length: 6, mix_case: false)}" }
    password_confirmation    { password }
    user_birth_date          { Faker::Date.in_date_period }
  end
end
