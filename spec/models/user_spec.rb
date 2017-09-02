require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  describe "admin?" do
    it "should be false" do
      expect(subject.admin?).not_to be_truthy
    end
  end

  context "with the admin role" do
    let(:user) { build(:admin_user) }

    describe "admin?" do
      it "should be true" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  context "without a role" do
    let(:user) { build(:user, role: nil) }

    it "should not be valid" do
      expect(user).not_to be_valid
      expect(user.errors.added?(:role, :blank)).to be_truthy
      expect(user.errors.added?(:role, :inclusion)).not_to be_truthy
    end
  end

  context "with an invalid role" do
    let(:user) { build(:user, role: "sl4ck3r") }

    it "should not be valid" do
      expect(user).not_to be_valid
      expect(user.errors.added?(:role, :inclusion)).to be_truthy
    end
  end
end
