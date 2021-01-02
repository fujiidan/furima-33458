module CreateItemSupport

  def create_item(item)

    click_on("出品する")
    expect(current_path).to eq new_item_path
    image_path = Rails.root.join('public/images/test_image.png')
    attach_file('item[image]', image_path)
    fill_in 'item-name', with: item.name
    fill_in 'item-info', with: item.text
    find("#item-category").find("option[value='1']").select_option
    find("#item-sales-status").find("option[value='1']").select_option
    find("#item-shipping-fee-status").find("option[value='1']").select_option
    find("#item-prefecture").find("option[value='1']").select_option
    find("#item-scheduled-delivery").find("option[value='1']").select_option
    fill_in 'item-price', with: item.price
    expect{click_on("出品する")}.to change{Item.count}.by(1)
    expect(current_path).to eq root_path
  end
  
end  
