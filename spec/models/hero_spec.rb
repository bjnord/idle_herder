require 'rails_helper'

RSpec.describe Hero, type: :model do
  subject { build(:hero) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "with stars too high" do
    let(:hero) { build(:hero, stars: 13) }

    it "should not be valid" do
      expect(hero).not_to be_valid
      expect(hero.errors.added?(:stars, :less_than_or_equal_to, count: Hero::MAX_STARS)).to be_truthy
    end
  end

  describe "#faction_name" do
    context "with Abyss value" do
      let(:hero) { build(:hero, faction: 2) }

      it "should be 'Abyss'" do
        expect(hero.faction_name).to be == 'Abyss'
      end
    end

    context "with nil" do
      let(:hero) { build(:hero, faction: nil) }

      it "should be nil" do
        expect(hero.faction_name).to be_nil
      end
    end
  end
end
