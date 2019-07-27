require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  
  describe 'コメントが有効' do
    it 'コメントが有効であること' do
      expect(comment).to be_valid
    end
  end

  describe 'コメントが無効' do
    it 'コメント内容が存在しない場合無効であること' do
      comment.content = ''
      expect(comment).to_not be_valid
    end

    it 'コメント内容が141文字以上の場合無効であること' do
      comment.content = 'a' * 141
      expect(comment).to_not be_valid
    end
  end
end