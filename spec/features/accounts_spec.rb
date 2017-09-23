require 'rails_helper'

RSpec.describe 'Accounts views', :type => :feature do
  let(:user) { create(:user) }
  let(:current_account) { user.accounts.first }
  before do
    login_as(user, scope: :user)
  end

  context '#show' do
    it 'generates the view' do
      visit "/accounts/#{current_account.id}"
      expect(find('#my-heroes-panel')).to have_content /My Heroes/
    end
  end

  context '#materials' do
    it 'generates the view' do
      visit "/accounts/#{current_account.id}/materials"
      expect(find('#three-star-fusion-panel')).to have_content /Three-Star Fusion/
    end
  end

  context '#goals' do
    it 'generates the view' do
      visit "/accounts/#{current_account.id}/goals"
      expect(find('#my-hero-fusions-panel')).to have_content /My Hero Fusions/
      expect(find('#my-wish-list-panel')).to have_content /My Wish List/
    end
  end
end
