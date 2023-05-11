require "rails_helper"
RSpec.describe "ユーザー管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe "ユーザー機能" do
    context "ユーザーを新規作成した場合" do
      it "作成したユーザー情報が表示される" do
        visit new_user_path
        fill_in 'Name', with: '新規ユーザー'
        fill_in 'Email', with: 'shinki@shinki.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on '登録'
        expect(page).to have_content '新規ユーザー'
        expect(page).to have_content 'shinki@shinki.com'
      end
    end
    context "ユーザーがログインせずタスク一覧画面に飛ぼうとした場合" do
      it "ログイン画面に遷移する" do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "セッション機能" do
    before do
      visit new_session_path
      fill_in 'Email', with: 'ippan@ippan.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
    context "ログインした場合" do
      it "自分の詳細画面(マイページ)に飛ぶ" do
        expect(page).to have_content '一般ユーザー'
        expect(page).to have_content 'ippan@ippan.com'
      end
    end
    context "一般ユーザーが他人の詳細画面に飛んだ場合" do
      it "タスク一覧画面に遷移する" do
        visit user_path(admin_user.id)
        expect(current_path).to eq tasks_path
      end
    end
    context "ログアウトした場合" do
      it "ログイン画面に遷移する" do
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "管理者機能" do
    before do
      visit new_session_path
      fill_in 'Email', with: 'kanri@kanri.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      click_on 'ユーザー一覧'
    end
    context "管理ユーザーが管理画面にアクセスした場合" do
      it "ユーザー一覧画面が表示される" do
        expect(current_path).to eq admin_users_path
      end
    end
    context "一般ユーザーが管理画面にアクセスした場合" do
      it "タスク一覧画面が表示される" do
        visit new_session_path
        fill_in 'Email', with: 'ippan@ippan.com'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end
    context "管理ユーザーがユーザーの新規登録をした場合" do
      it "作成したユーザー情報が表示される" do
        visit new_admin_user_path
        fill_in 'Name', with: 'テストユーザー'
        fill_in 'Email', with: 'test@test.com'
        check "user_admin"
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on '登録'
        expect(page).to have_content 'テストユーザー'
        expect(page).to have_content 'test@test.com'
      end
    end
    context "管理ユーザーが詳細画面にアクセスした場合" do
      it "ユーザーの詳細画面が表示される" do
        click_on '詳細', match: :first
        expect(page).to have_content '一般ユーザー'
        expect(page).to have_content 'ippan@ippan.com'
      end
    end
    context "管理ユーザーがユーザー情報を編集した場合" do
      it "編集した詳細画面が表示される" do
        click_on '編集', match: :first
        fill_in 'Name', with: 'テストユーザー'
        fill_in 'Email', with: 'test@test.com'
        check "user_admin"
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on '登録'
        expect(page).to have_content 'テストユーザー'
        expect(page).to have_content 'test@test.com'
      end
    end
    context "管理ユーザーがユーザーを削除した場合の場合" do
      it "ユーザー情報が無くなる" do
        accept_alert do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'ユーザー「一般ユーザー」を削除しました'
      end
    end
  end
end