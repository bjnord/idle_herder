require 'rails_helper'

RSpec.describe ShardType, type: :model do
  subject { build(:shard_type) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "with stars too low" do
    let(:shard_type) { build(:shard_type, stars: 2) }

    it "should not be valid" do
      expect(shard_type).not_to be_valid
      expect(shard_type.errors.added?(:stars, :greater_than_or_equal_to, count: 3)).to be_truthy
    end
  end

  context "with stars too high" do
    let(:shard_type) { build(:shard_type, stars: 6) }

    it "should not be valid" do
      expect(shard_type).not_to be_valid
      expect(shard_type.errors.added?(:stars, :less_than_or_equal_to, count: 5)).to be_truthy
    end
  end
end
