require 'rails_helper'

RSpec.describe AccountHero, type: :model do
  it "cannot be directly instantiated" do
    expect { AccountHero.new }.to raise_error(PureParentClassError)
  end
end
