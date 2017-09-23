require 'rails_helper'

RSpec.describe 'Goal decorators', :type => :feature do
  let(:user) { create(:user) }
  let(:current_account) { user.accounts.first }
  before do
    login_as(user, scope: :user)
  end

  context 'fusion requirement met' do
    # FIXME extract this complexity to a factory
    # - hero is the Hero we're going to make (5* Buckwheat)
    # - lesser_hero is the primary Hero you fuse to make it (4* Buckwheat)
    #   -- my_lesser_hero is an AccountHero of that type
    let(:hero) { create(:shardable_hero, stars: 5) }
    let(:lesser_hero) { create(:shardable_hero, name: hero.name, stars: hero.stars - 1, faction: hero.faction, role: hero.role) }
    let!(:material) { create(:material, hero: hero, material_hero: lesser_hero, count: 1) }
    let!(:my_lesser_hero) { create(:specific_account_hero, account: current_account, hero: lesser_hero, target_stars: hero.stars) }

    it 'generates a checkmark decorator' do
      visit "/accounts/#{current_account.id}/goals"
      #$stderr.puts find('.fusions-table').native.to_html
      within('ul.fusion-materials') do
        expect(find('div.hero-image')).to have_selector 'div.fusion-decorator.check'
      end
    end
  end

  context 'fusion requirement not met' do
    # FIXME extract this complexity to a factory
    # - hero is the Hero we're going to make (5* Buckwheat)
    # - lesser_hero is the primary Hero you fuse to make it (4* Buckwheat)
    #   -- my_lesser_hero is an AccountHero of that type
    # - other_hero is a required material (3* Petey)
    let(:hero) { create(:shardable_hero, stars: 5) }
    let(:lesser_hero) { create(:shardable_hero, name: hero.name, stars: hero.stars - 1, faction: hero.faction, role: hero.role) }
    let(:other_hero) { create(:shardable_hero, stars: hero.stars - 2, faction: hero.faction, role: hero.role) }
    let!(:material) { create(:material, hero: hero, material_hero: other_hero, count: 1) }
    let!(:my_lesser_hero) { create(:specific_account_hero, account: current_account, hero: lesser_hero, target_stars: hero.stars) }

    it 'generates a checkmark decorator' do
      visit "/accounts/#{current_account.id}/goals"
      #$stderr.puts find('.fusions-table').native.to_html
      within('ul.fusion-materials') do
        expect(find('div.hero-image')).to have_selector 'div.fusion-decorator.ex'
      end
    end
  end

  context 'fusion requirement maybe met' do
    # FIXME extract this complexity to a factory
    # - hero is the Hero we're going to make (5* Buckwheat)
    # - lesser_hero is the primary Hero you fuse to make it (4* Buckwheat)
    #   -- my_lesser_hero is an AccountHero of that type
    # - material is generic (4* faction)
    #   -- my_other_hero (non-fodder) matches this requirement
    let(:hero) { create(:shardable_hero, stars: 5) }
    let(:lesser_hero) { create(:shardable_hero, name: hero.name, stars: hero.stars - 1, faction: hero.faction, role: hero.role) }
    let!(:material) { create(:generic_material, hero: hero, stars: hero.stars - 1, faction: hero.faction, count: 1) }
    let(:other_hero) { create(:shardable_hero, stars: hero.stars - 1, faction: hero.faction, role: hero.role) }
    let!(:my_lesser_hero) { create(:specific_account_hero, account: current_account, hero: lesser_hero, target_stars: hero.stars) }
    let!(:my_other_hero) { create(:specific_account_hero, account: current_account, hero: other_hero, is_fodder: false) }

    it 'generates a checkmark decorator' do
      visit "/accounts/#{current_account.id}/goals"
      #$stderr.puts find('.fusions-table').native.to_html
      within('ul.fusion-materials') do
        expect(find('div.hero-image')).to have_selector 'div.fusion-decorator.qn'
      end
    end
  end
end
