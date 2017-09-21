require 'rails_helper'

RSpec.describe AccountHero, type: :model do
  context "without hero or shard_type" do
    let(:account_hero) { build(:account_hero, hero: nil, shard_type: nil) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:base, :hero_or_shard_type_required)).to be_truthy
    end

    it "should have an empty target" do
      expect(account_hero.target).to be_nil
    end
  end

  context "with both hero and shard_type" do
    let(:hero) { build(:hero) }
    let(:account_hero) { build(:generic_sharded_account_hero, hero: hero) }

    it "should be invalid" do
      expect(account_hero).not_to be_valid
      expect(account_hero.errors.added?(:base, :hero_and_shard_type_together_invalid)).to be_truthy
    end
  end

  context "specific hero (stars/name/faction)" do
    # with level, without shards = default
    subject { build(:account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end
    it "should have a Hero target" do
      expect(subject.target).to be_a_kind_of(Hero)
    end
    it "should not be sharded" do
      expect(subject.sharded?).to be_falsey
    end

    context "with nil level" do
      let(:account_hero) { build(:sharded_account_hero, level: nil) }

      it "should be valid" do
        expect(account_hero).to be_valid
        expect(account_hero[:level]).to be == 0
      end
    end

    context "with nil shards" do
      let(:account_hero) { build(:account_hero, shards: nil) }

      it "should be valid, and have zero underneath" do
        expect(account_hero).to be_valid
        expect(account_hero[:shards]).to be == 0
      end
    end

    context "without level or shards or wish_list" do
      let(:account_hero) { build(:sharded_account_hero, level: nil, shards: nil, wish_list: false) }

      it "should be invalid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:base, :level_or_shards_required)).to be_truthy
      end
    end

    context "without level but with shards" do
      let(:account_hero) { build(:sharded_account_hero) }

      it "should be valid" do
        expect(account_hero).to be_valid
      end
      it "should be sharded" do
        expect(account_hero.sharded?).to be_truthy
      end
    end

    context "with both level and shards" do
      let(:account_hero) { build(:account_hero, level: 10, shards: 15) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:base, :level_and_shards_together_invalid)).to be_truthy
      end
    end

    context "with max level" do
      let(:hero) { build(:five_star_hero) }
      let(:account_hero) { build(:account_hero, hero: hero, level: 100) }

      it "should be valid" do
        expect(account_hero).to be_valid
      end
    end

    context "just over max level" do
      let(:hero) { build(:five_star_hero) }
      let(:account_hero) { build(:account_hero, hero: hero, level: 101) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:level, :cannot_exceed_for_this_hero, maximum: 100)).to be_truthy
      end
    end

    context "with shards for a non-shardable hero" do
      let(:hero) { build(:ten_star_hero) }
      let(:account_hero) { build(:sharded_account_hero, hero: hero) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:shards, :invalid_for_this_hero)).to be_truthy
      end
    end

    context "with target_stars below 1" do
      let(:account_hero) { build(:account_hero, target_stars: 0) }

      it "should be invalid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:target_stars, :greater_than, count: 0)).to be_truthy
      end
    end

    context "with target_stars too low for hero" do
      let(:hero) { build(:hero, stars: 3, is_natural: false, max_stars: 3) }
      let(:account_hero) { build(:account_hero, hero: hero, target_stars: 2) }

      it "should be invalid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:target_stars, :must_be_at_least_for_this_hero, minimum: 3)).to be_truthy
      end
    end

    context "with target_stars allowable for hero" do
      let(:hero) { build(:hero, stars: 4, is_natural: false, max_stars: 5) }
      let(:account_hero) { build(:account_hero, hero: hero, target_stars: 5) }

      it "should be valid" do
        expect(account_hero).to be_valid
      end
    end

    context "with target_stars too high for hero" do
      let(:hero) { build(:hero, stars: 5, is_natural: false, max_stars: 5) }
      let(:account_hero) { build(:account_hero, hero: hero, target_stars: 6) }

      it "should be invalid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:target_stars, :cannot_exceed_for_this_hero, maximum: 5)).to be_truthy
      end
    end

    context "without target_stars for sharded_account_hero" do
      let(:account_hero) { create(:sharded_account_hero, target_stars: nil) }

      it "should be valid, and fill in target_stars" do
        expect(account_hero).to be_valid
        expect(account_hero.target_stars).to be == account_hero.target_stars
      end
    end

    context "with target_stars too high for sharded_account_hero" do
      let(:hero) { build(:shardable_hero, stars: 4) }
      let(:account_hero) { build(:sharded_account_hero, hero: hero, target_stars: 6) }

      it "should be valid, and override target_stars" do
        expect(account_hero).to be_valid
        expect(account_hero.target_stars).to be == account_hero.target_stars
      end
    end

    context "three-star hero without fodder flag set" do
      let(:hero) { build(:hero, stars: 3, max_stars: 3) }
      let(:account_hero) { build(:account_hero, hero: hero, is_fodder: false) }

      it "should be considered fodder" do
        expect(account_hero).to be_valid
        expect(account_hero.fodder?).to be_truthy
      end
    end

    context "three-star shard_type without fodder flag set" do
      let(:hero) { build(:shardable_hero, stars: 3, max_stars: 3) }
      let(:account_hero) { build(:sharded_account_hero, hero: hero, is_fodder: false) }

      it "should be considered fodder" do
        expect(account_hero).to be_valid
        expect(account_hero.fodder?).to be_truthy
      end
    end

    pending "#wish_list?"
  end

  context "generic hero (stars/faction in shards)" do
    subject { build(:generic_sharded_account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end
    it "should have a ShardType target" do
      expect(subject.target).to be_a_kind_of(ShardType)
    end
    it "should be sharded" do
      expect(subject.sharded?).to be_truthy
    end

    context "with level" do
      let(:account_hero) { build(:generic_sharded_account_hero, level: 12) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:level, :invalid)).to be_truthy
      end
    end

    context "without shards" do
      let(:account_hero) { build(:generic_sharded_account_hero, shards: nil) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:shards, :missing)).to be_truthy
      end
    end

    pending "#wish_list?"
  end

  context "wish list hero (stars/name/faction)" do
    subject { build(:wish_list_account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end

    pending "#wish_list?"
    pending "wish list hero can't have is_fodder flag set"
  end
end
