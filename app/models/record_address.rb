class RecordAddress
  include ActiveModel::Model
  # テーブルに保存したいカラム名を全て指定する
  attr_accessor :user_id, :item_id, :potal_code, :prefecture_id, :city, :address, :building, :phone_number

  # ここにバリデーションをかく 元のモデルのバリデーションは消す
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number
  end

  # データをテーブルに保存する処理を記述する
  def save
    record = Record.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(potal_code: potal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, record_id: record_id.id)
  end
end