module FeatureHelpers
  def sign_in_partner(user)
    visit new_partner_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_in_customer(user)
    visit new_customer_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end
