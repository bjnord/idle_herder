require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { build(:account) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a player_id" do
    let(:account) { build(:account, player_id: nil) }

    it "should be valid" do
      expect(account).to be_valid
    end
  end

  context "with a valid player_id" do
    let(:account) { build(:account, player_id: "01234567") }

    it "should be valid" do
      expect(account).to be_valid
    end
  end

  context "with an invalid player_id" do
    let(:account) { build(:account, player_id: "0340B33F") }

    it "should not be valid" do
      expect(account).not_to be_valid
      expect(account.errors.added?(:player_id, :invalid)).to be_truthy
    end
  end
end
