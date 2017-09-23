require 'rails_helper'

RSpec.describe 'Hero decorators', :type => :feature do
  let(:user) { create(:user) }
  let(:current_account) { user.accounts.first }
  before do
    login_as(user, scope: :user)
  end

  # NOTE we use the accounts#materials page as a simpla Rails-only place
  #      we can see decorators, but for heroes to appear there, they have
  #      to be marked as fodder

  context 'AccountHero.leveled?' do
    let!(:account_hero) { create(:specific_account_hero, account: current_account, is_fodder: true) }

    it 'generates a level decorator' do
      visit "/accounts/#{current_account.id}/materials"
      within('#materials-hero-box') do
        expect(find('div.hero-image')).to have_selector 'div.level'
        expect(find('div.level')).to have_content account_hero.level.to_s
      end
    end
  end

  context 'AccountHero.sharded?' do
    let(:shardable_hero) { create(:shardable_hero, stars: 4) }
    let!(:sharded_account_hero) { create(:sharded_specific_account_hero, account: current_account, hero: shardable_hero, shards: 19, is_fodder: true) }

    it 'generates a shard decorator and fraction' do
      visit "/accounts/#{current_account.id}/materials"
      within('#materials-hero-box') do
        expect(find('div.hero-image')).to have_selector 'img.puzzle-piece'
        expect(find('div.shards-count')).to have_content '19 / 30'
      end
    end
  end
end
