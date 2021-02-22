require 'rails_helper'

RSpec.describe Airplain, type: :model do
  it 'is valid with valid attributes' do
    expect(Airplain.new).to be_valid
  end
end
