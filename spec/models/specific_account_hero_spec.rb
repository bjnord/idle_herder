require 'rails_helper'

RSpec.describe SpecificAccountHero, type: :model do
  # with level, without shards = default
  subject { build(:specific_account_hero) }
  it "should be valid" do
    expect(subject).to be_valid
  end
  it "should have box_type=hero" do
    expect(subject.box_type).to be == 'hero'
  end
  it "should not be sharded" do
    expect(subject.sharded?).to be_falsey
  end
  it "should not be wish_list" do
    expect(subject.wish_list?).to be_falsey
  end
  it "should provide Hero attributes directly" do
    expect(subject.name).to be == subject.hero.name
    expect(subject.role).to be == subject.hero.role
  end
  it "should still respond to missing methods" do
    expect{subject.xyzzy}.to raise_error(NoMethodError)
  end
  it "should NOT allow assignment via metaprogramming" do
    expect{subject.name = 'Plugh'}.to raise_error(NoMethodError)
    expect{subject.role = 'Y2'}.to raise_error(NoMethodError)
  end

  context "without hero" do
    let(:account_hero) { build(:specific_account_hero, hero: nil) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:hero, :blank)).to be_truthy
    end
    it "should not provide Hero attributes directly" do
      expect{account_hero.name}.to raise_error(NoMethodError)
      expect{account_hero.role}.to raise_error(NoMethodError)
    end
  end

  context "with nil level" do
    let(:account_hero) { build(:sharded_specific_account_hero, level: nil) }

    it "should be valid (treat as 0)" do
      expect(account_hero).to be_valid
      expect(account_hero[:level]).to be == 0
    end
  end

  context "with nil shards" do
    let(:account_hero) { build(:specific_account_hero, shards: nil) }

    it "should be valid (treat as 0)" do
      expect(account_hero).to be_valid
      expect(account_hero[:shards]).to be == 0
    end
  end

  context "without level or shards or wish_list" do
    let(:account_hero) { build(:sharded_specific_account_hero, level: nil, shards: nil, wish_list: false) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:base, :level_or_shards_required)).to be_truthy
    end
  end

  context "without level but with shards" do
    let(:account_hero) { build(:sharded_specific_account_hero) }

    it "should be valid" do
      expect(account_hero).to be_valid
    end
    it "should have box_type=hero-shards" do
      expect(account_hero.box_type).to be == 'hero-shards'
    end
    it "should be sharded" do
      expect(account_hero.sharded?).to be_truthy
    end
    it "should not be wish_list" do
      expect(account_hero.wish_list?).to be_falsey
    end
  end

  context "with both level and shards" do
    let(:account_hero) { build(:specific_account_hero, level: 10, shards: 15) }

    it "should not be valid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:base, :level_and_shards_together_invalid)).to be_truthy
    end
  end

  context "with max level" do
    let(:hero) { build(:five_star_hero) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, level: 100) }

    it "should be valid" do
      expect(account_hero).to be_valid
    end
  end

  context "just over max level" do
    let(:hero) { build(:five_star_hero) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, level: 101) }

    it "should not be valid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:level, :cannot_exceed_for_this_hero, maximum: 100)).to be_truthy
    end
  end

  context "with shards for a non-shardable hero" do
    let(:hero) { build(:ten_star_hero) }
    let(:account_hero) { build(:sharded_specific_account_hero, hero: hero) }

    it "should not be valid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:shards, :invalid_for_this_hero)).to be_truthy
    end
  end

  context "without target_stars for a non-sharded hero" do
    let(:account_hero) { build(:specific_account_hero, target_stars: nil) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:target_stars, :blank)).to be_truthy
    end
  end

  context "without target_stars for sharded hero" do
    let(:account_hero) { create(:sharded_specific_account_hero, target_stars: nil) }

    it "should be valid, and fill in target_stars" do
      expect(account_hero).to be_valid
      expect(account_hero.target_stars).to be == account_hero.hero.stars
    end
  end

  context "with target_stars below 1" do
    let(:account_hero) { build(:specific_account_hero, target_stars: 0) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:target_stars, :greater_than, count: 0)).to be_truthy
    end
  end

  context "with target_stars too low for hero" do
    let(:hero) { build(:hero, stars: 3, is_natural: false, max_stars: 3) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, target_stars: 2) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:target_stars, :must_be_at_least_for_this_hero, minimum: 3)).to be_truthy
    end
  end

  context "with target_stars below hero max_stars" do
    let(:hero) { build(:hero, stars: 4, is_natural: false, max_stars: 5) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, target_stars: 5) }

    it "should be valid" do
      expect(account_hero).to be_valid
    end
    it "should be understarred" do
      expect(account_hero.understarred?).to be_truthy
    end
  end

  context "with target_stars equal to hero max_stars" do
    let(:hero) { build(:hero, stars: 5, is_natural: false, max_stars: 5) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, target_stars: 5) }

    it "should be valid" do
      expect(account_hero).to be_valid
    end
    it "should not be understarred" do
      expect(account_hero.understarred?).to be_falsey
    end
  end

  context "with target_stars too high for hero" do
    let(:hero) { build(:hero, stars: 5, is_natural: false, max_stars: 5) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, target_stars: 6) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:target_stars, :cannot_exceed_for_this_hero, maximum: 5)).to be_truthy
    end
  end

  context "with target_stars too high for sharded hero" do
    let(:hero) { build(:shardable_hero, stars: 4) }
    let(:account_hero) { build(:sharded_specific_account_hero, hero: hero, target_stars: 6) }

    it "should be valid, and override target_stars" do
      expect(account_hero).to be_valid
      expect(account_hero.target_stars).to be == account_hero.target_stars
    end
  end

  context "three-star hero without fodder flag set" do
    let(:hero) { build(:hero, stars: 3, max_stars: 3) }
    let(:account_hero) { build(:specific_account_hero, hero: hero, is_fodder: false) }

    it "should be considered fodder" do
      expect(account_hero).to be_valid
      expect(account_hero.fodder?).to be_truthy
    end
  end

  context "wish list hero (stars/name/faction)" do
    subject { build(:wish_list_account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end
    it "should have box_type=wish-list" do
      expect(subject.box_type).to be == 'wish-list'
    end
    it "should be wish_list" do
      expect(subject.wish_list).to be_truthy
    end

    pending "wish list hero can't have is_fodder flag set"
  end
end
