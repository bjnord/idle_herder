require 'rails_helper'

RSpec.describe 'Signing in', :type => :feature do
  before do
    FactoryGirl.create(:user, email: 'user@example.net', password: 'sign_me_in')
  end

  scenario 'Signing in with correct credentials' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.net'
      fill_in 'Password', with: 'sign_me_in'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Signing in with incorrect credentials' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.net'
      fill_in 'Password', with: 'dont_sign_me_in'
    end
    click_button 'Sign in'
    expect(page).to have_content /Invalid email or password\./i
  end
end
