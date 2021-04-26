class Item < ApplicationRecord
  belongs_to :user
  has_one    :record
  has_one_attached :image
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end
