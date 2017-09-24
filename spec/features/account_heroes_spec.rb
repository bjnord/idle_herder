require 'rails_helper'

RSpec.describe 'AccountHeroes views', js: true, type: :feature do
  let(:user) { create(:user) }
  let(:current_account) { user.accounts.first }
  before do
    login_as(user, scope: :user)
  end

  context '#edit non-fodder hero with level' do
    let!(:account_hero) { create(:fusable_specific_account_hero, account: current_account, is_fodder: false) }

    it 'generates the view' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find('.edit_specific_account_hero')).to have_content /Level.*Shards/
    end

    it 'has the correct target-stars value selected' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find('#specific_account_hero_target_stars_' + account_hero.target_stars.to_s).checked?).to be_truthy
    end

    it "doesn't change target-stars when level is changed" do
      visit "/account_heroes/#{account_hero.id}/edit"
      fill_in 'Level', with: '25'
      expect(find('#specific_account_hero_target_stars_' + account_hero.target_stars.to_s).checked?).to be_truthy
    end

    it 'clears level when shards is filled in' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find_field('Level').value).not_to be == ''
      fill_in 'Shards', with: '15'
      expect(find_field('Level').value).to be == ''
    end

    it 'hides target_stars when shards is filled in' do
      visit "/account_heroes/#{account_hero.id}/edit"
      #$stderr.puts find('.edit_specific_account_hero').native.attribute('innerHTML')
      #byebug
      expect(find('.edit_specific_account_hero')).to have_selector '.target-stars', visible: true
      fill_in 'Shards', with: '16'
      expect(find('.edit_specific_account_hero')).not_to have_selector '.target-stars', visible: true
    end

    it 'changes the target-stars value when fodder is checked/unchecked' do
      visit "/account_heroes/#{account_hero.id}/edit"
      check 'Fodder?'
      expect(find('#specific_account_hero_target_stars_' + account_hero.stars.to_s).checked?).to be_truthy
      uncheck 'Fodder?'
      expect(find('#specific_account_hero_target_stars_' + account_hero.max_stars.to_s).checked?).to be_truthy
    end
  end

  context '#edit hero with shards' do
    let!(:account_hero) { create(:sharded_specific_account_hero, account: current_account) }

    it 'generates the view' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find('.edit_specific_account_hero')).to have_content /Level.*Shards/
    end

    it 'clears shards when level is filled in' do
      visit "/account_heroes/#{account_hero.id}/edit"
      expect(find_field('Shards').value).not_to be == ''
      fill_in 'Level', with: '20'
      expect(find_field('Shards').value).to be == ''
    end

    it 'shows target_stars when level is filled in' do
      visit "/account_heroes/#{account_hero.id}/edit"
      #$stderr.puts find('.edit_specific_account_hero').native.attribute('innerHTML')
      #byebug
      expect(find('.edit_specific_account_hero')).not_to have_selector '.target-stars', visible: true
      fill_in 'Level', with: '21'
      expect(find('.edit_specific_account_hero')).to have_selector '.target-stars', visible: true
    end

    it 'sets the highest target-stars value when level is filled in' do
      visit "/account_heroes/#{account_hero.id}/edit"
      fill_in 'Level', with: '22'
      expect(find('#specific_account_hero_target_stars_' + account_hero.hero.max_stars.to_s).checked?).to be_truthy
    end
  end
end
