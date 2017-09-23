require 'rails_helper'

RSpec.describe 'AccountHeroes views', :type => :feature do
  let(:user) { create(:user) }
  let(:current_account) { user.accounts.first }
  before do
    login_as(user, scope: :user)
  end

  context '#edit' do
    let!(:account_hero) { create(:specific_account_hero, account: current_account) }

    it 'generates the view' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find('.edit_specific_account_hero')).to have_content /Level.*Shards/
    end
  end
end
