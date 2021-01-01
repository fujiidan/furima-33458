class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name, length: {maximum: 40 }
    validates :text, length: {maximum: 1000 }
    validates :price, numericality: {only_integer: true, message: "Half-width number" }
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :price, numericality: {
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

end
