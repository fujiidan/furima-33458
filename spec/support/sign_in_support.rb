module SignInSupport
  
  def sign_in(user)
    visit new_user_registration_path
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password
    fill_in 'last-name', with: user.last_name
    fill_in 'first-name', with: user.first_name
    fill_in 'last-name-kana', with: user.last_name_kana
    fill_in 'first-name-kana', with: user.first_name_kana
    select(value= "1930", from: "user[user_birth_date(1i)]")
    select(value= "2", from: "user[user_birth_date(2i)]")
    select(value= "3", from: "user[user_birth_date(3i)]")
    click_on("会員登録")
    expect(current_path).to eq root_path
  end
  
end  
