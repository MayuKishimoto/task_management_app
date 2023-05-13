require 'rails_helper'

RSpec.describe Label, type: :model do
  it "有効なlabelを生成できる" do
    expect(FactoryBot.create(:label)).to be_valid
  end
end
