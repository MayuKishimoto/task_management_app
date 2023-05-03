require "rails_helper"
RSpec.describe "タスク管理機能", type: :system do
  let!(:first_task) { FactoryBot.create(:task, title: 'タイトル１', content: 'コンテント１') }
  let!(:second_task) { FactoryBot.create(:task, title: 'タイトル２', content: 'コンテント２') }
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in 'Title', with: 'タイトル'
        fill_in 'Content', with: 'コンテント'
        click_on '登録'
        expect(page).to have_content 'タイトル'
        expect(page).to have_content 'コンテント'
      end
    end
  end
  describe "一覧表示機能" do
    before do
      visit tasks_path
    end
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        current_path
        Task.count
        page.html
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list.first).to have_content 'タイトル２'
      end
    end
  end
  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        # # テストで使用するためのタスクを作成
        # task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # 「詳細」というvalue（表記文字）のあるボタンをクリックする
        click_on '詳細', match: :first
        # 表示するページにタスク情報が入っているかを確認
        page.html
        expect(page).to have_content 'タイトル'
      end
    end
  end
end
