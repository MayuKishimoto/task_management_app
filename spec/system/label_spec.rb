require "rails_helper"
RSpec.describe "ラベル登録機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:third_label) { FactoryBot.create(:third_label) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }

  before do
    visit new_session_path
    fill_in 'Email', with: 'ippan@ippan.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  describe "ラベル登録機能" do
    context "タスクを新規作成した場合" do
      it "複数のラベルをつけることができる" do
        visit new_task_path
        fill_in 'Title', with: 'タイトル０'
        fill_in 'Content', with: 'コンテント０'
        check "ラベル１"
        check "ラベル２"
        check "ラベル３"
        click_on '登録'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content 'ラベル２'
        expect(page).to have_content 'ラベル３'
      end
    end
    context "タスクを編集した場合" do
      it "ラベルも編集することができる" do
        click_on 'タスク一覧'
        click_on '編集', match: :first
        check "ラベル１"
        check "ラベル２"
        click_on '登録'
        expect(page).to have_content "タスクを編集しました！"
      end
    end
    context "ラベルで検索をかけた場合" do
      it "ラベルに紐づいたタスクを検索することができる" do
        visit new_task_path
        fill_in 'Title', with: 'タイトル０'
        fill_in 'Content', with: 'コンテント０'
        check "ラベル１"
        click_on '登録'
        click_on '登録'
        click_on 'タスク一覧'
        select 'ラベル１',from: 'task[label_id]'
        click_on '検索'
        expect(page).to have_content 'タイトル０'
      end
    end
  end
end