FactoryBot.define do
  factory :items_tag do
    name { Faker::Name.initials(number: 2) }
    info { Faker::Lorem.sentence }
    category_id { 2 }
    sales_status_id { 2 }
    tag_name {"野菜,画像"}
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 3000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
