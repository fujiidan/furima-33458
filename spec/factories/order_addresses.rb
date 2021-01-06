FactoryBot.define do
  factory :order_address do
    postal_code   {"123-4567"}
    prefecture_id {1}
    city          {"品川区"}
    addresses     {"1-1-1"}
    building      {"テストマンション"}
    phone_number  {"09012345678"}
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
