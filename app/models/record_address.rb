class RecordAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :potal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :potal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
    validates :city
    validates :address
    validates :token
  end
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'Input only number' }

  def save
    record = Record.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(potal_code: potal_code, prefecture_id: prefecture_id, city: city, address: address,
                           building: building, phone_number: phone_number, record_id: record.id)
  end
end
