require 'rails_helper'

RSpec.describe Material, type: :model do
  subject { build(:material) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  describe "#faction_name" do
    context "with Fortress value" do
      let(:material) { build(:material, faction: 1) }

      it "should be 'Fortress'" do
        expect(material.faction_name).to be == 'Fortress'
      end
    end

    context "with nil" do
      let(:material) { build(:material, faction: nil) }

      it "should be nil" do
        expect(material.faction_name).to be_nil
      end
    end
  end
end
