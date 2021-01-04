class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :text, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, message: 'Half-width number' }
  end

  with_options numericality: { other_than: 0, message: 'Select' } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :price, numericality: {
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range'
  }
end
