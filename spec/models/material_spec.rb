require 'rails_helper'

RSpec.describe Material, type: :model do
  subject { build(:material) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "with no material_hero, stars, or faction" do
    let(:material) { build(:material, material_hero: nil, stars: nil, faction: nil) }

    it "should be invalid" do
      expect(material).not_to be_valid
      expect(material.errors.added?(:base, :material_target_blank)).to be_truthy
    end
  end

  describe "#faction_name" do
    context "with Fortress value" do
      let(:material) { build(:generic_material, faction: 1) }

      it "should be 'Fortress'" do
        expect(material.faction_name).to be == 'Fortress'
      end
    end

    context "with nil" do
      let(:material) { build(:generic_material, faction: nil) }

      it "should be nil" do
        expect(material.faction_name).to be_nil
      end
    end
  end
end
