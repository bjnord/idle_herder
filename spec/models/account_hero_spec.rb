require 'rails_helper'

RSpec.describe AccountHero, type: :model do
  context "specific hero (stars/name/faction)" do
    # with level, without shards = default
    subject { build(:account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end

    context "with nil level" do
      let(:account_hero) { build(:account_hero, level: nil) }

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

    context "without level but with shards" do
      let(:account_hero) { build(:sharded_account_hero) }

      it "should be valid" do
        expect(account_hero).to be_valid
      end
    end

    context "with both level and shards" do
      let(:account_hero) { build(:account_hero, level: 10, shards: 15) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:base, 'Using both level and shards is invalid')).to be_truthy
      end
    end
  end

  context "generic hero (stars/faction in shards)" do
    subject { build(:generic_sharded_account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end

    context "with hero" do
      let(:account_hero) { build(:generic_sharded_account_hero, hero: FactoryGirl.build(:hero)) }

      it "should not be valid" do
        expect(account_hero).not_to be_valid
        expect(account_hero.errors.added?(:base, 'Using both hero and shard_type is invalid')).to be_truthy
      end
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
  end

  context "wish list hero (stars/name/faction)" do
    subject { build(:wish_list_account_hero) }
    it "should be valid" do
      expect(subject).to be_valid
    end
  end
end
