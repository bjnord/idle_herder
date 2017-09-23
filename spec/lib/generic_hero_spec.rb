require 'rails_helper'

RSpec.describe GenericHero do
  subject { build(:generic_hero) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "with stars too low" do
    let(:generic_hero) { build(:generic_hero, stars: 2) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end

  context "with stars=3 and faction" do
    let(:generic_hero) { build(:generic_hero, stars: 3, faction: 1) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end

  context "with stars=7" do
    let(:generic_hero) { build(:generic_hero, stars: 7) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end

  context "with stars=8" do
    let(:generic_hero) { build(:generic_hero, stars: 8) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end

  context "with stars=9" do
    let(:generic_hero) { build(:generic_nine_star_hero) }

    it "should be valid" do
      expect(generic_hero).to be_valid
    end
  end

  context "with stars=9 and faction" do
    let(:generic_hero) { build(:generic_nine_star_hero, faction: 4) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end

  context "with stars too high" do
    let(:generic_hero) { build(:generic_hero, stars: 10) }

    it "should not be valid" do
      expect(generic_hero).not_to be_valid
    end
  end
end
