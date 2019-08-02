require 'rails_helper'

describe 'フォロー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }

  describe '他のユーザーをフォローしていない場合' do

    context 'ユーザー詳細ページからフォローする場合' do
      before do
        sign_in_as user
        visit user_path(other_user)
        click_on 'フォローする'
        wait_for_ajax
      end
  
      it 'フォローできること' do
        expect(page).to have_css '.profile-block .profile-block__link--unfollow'
      end
      # it 'フォローできること' do
      #   sign_in_as user
      #   visit user_path(other_user)
      #   expect {
      #     click_on "フォローする"
      #     wait_for_ajax
      #   }.to change(Relationship, :count).by(1)
      # end
    end

    context 'フォロワー一覧ページからフォローする場合' do
      before do
        FactoryBot.create(:relationship, follower: other_user, followed: user)
        sign_in_as user
        visit followers_user_path(user)
        click_on 'フォローする'
        wait_for_ajax
      end
  
      it 'フォローできること' do
        expect(page).to have_css '.user-card .profile-block__link--unfollow'
      end
      # it 'フォローできること' do
      #   sign_in_as user
      #   visit followers_user_path(user)
      #   expect {
      #     click_on "フォローする"
      #     wait_for_ajax
      #   }.to change(Relationship, :count).by(1)
      # end
    end
  end

  describe '他のユーザーをフォローしている場合' do
    before do
      FactoryBot.create(:relationship, follower: user, followed: other_user)
    end

    context 'ユーザー詳細ページからフォロー解除する場合' do
      before do
        sign_in_as user
        visit user_path(other_user)
        click_on 'フォロー中'
        page.driver.browser.switch_to.alert.accept
        wait_for_ajax
      end
  
      it 'フォロー解除できること' do
        expect(page).to have_css '.profile-block .profile-block__link--follow'
      end
      # it 'フォローできること' do
      #   sign_in_as user
      #   visit user_path(other_user)
      #   expect {
      #     visit user_path(other_user)
            # click_on 'フォロー中'
            # page.driver.browser.switch_to.alert.accept
      #     wait_for_ajax
      #   }.to change(Relationship, :count).by(1)
      # end
    end

    context 'フォロー一覧ページからフォロー解除する場合' do
      before do
        sign_in_as user
        visit following_user_path(user)
        click_on 'フォロー中'
        page.driver.browser.switch_to.alert.accept
        wait_for_ajax
      end
  
      it 'フォロー解除できること' do
        expect(page).to have_css '.user-card .profile-block__link--follow'
      end
      # it 'フォローできること' do
      #   sign_in_as user
      #   visit following_user_path(user)
      #   expect {
      #     click_on "フォロー中"
            # page.driver.browser.switch_to.alert.accept
      #     wait_for_ajax
      #   }.to change(Relationship, :count).by(1)
      # end
    end
  end
end