class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}[-][0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: {other_than: 0, message: "Select"}
    validates :city
    validates :addresses
    validates :phone_number, format: {with: /\A\d{10, 11}\z/i, message: "input only number"}
  end

  def save
    oreder = Order.create(user_id: current_user.id, item_id: params[:item_id])
    addresses.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                     building: building, addresses: addresses, phone_number: phone_number, order_id: order.id)
  end

end