FactoryBot.define do
  factory :record_address do
    potal_code    { '111-1111' }
    prefecture_id { 3 }
    city          { '横浜市緑区' }
    address       { '1-1' }
    building      { '東京ハイツ' }
    phone_number  { '08012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
