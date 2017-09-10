require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:hero) }
  it "should be valid" do
    expect(subject).to be_valid
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
