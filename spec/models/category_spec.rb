require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.create(:category) }

  describe 'カテゴリーが有効' do
    it 'カテゴリーが有効であること' do
      expect(category).to be_valid
    end
  end

  describe 'カテゴリーが無効' do
    it 'カテゴリー名が存在しない場合無効であること' do
      category.name = ''
      expect(category).to_not be_valid
    end

    it 'カテゴリー名が20文字以上の場合無効であること' do
      category.name = 'a' * 21
      expect(category).to_not be_valid
    end
  end
end