require "rails_helper"
RSpec.describe "タスク管理機能", type: :system do
  let!(:first_task) { FactoryBot.create(:task, title: 'タイトル１', content: 'コンテント１', expired_at: '2024-01-02 00:00:00', status: '未着手') }
  let!(:second_task) { FactoryBot.create(:task, title: 'タイトル２', content: 'コンテント２', expired_at: '2024-01-01 00:00:00', status: '未着手') }
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in 'Title', with: 'タイトル０'
        fill_in 'Content', with: 'コンテント０'
        select '2024',from: 'task[expired_at(1i)]'
        select '1月',from: 'task[expired_at(2i)]'
        select '1',from: 'task[expired_at(3i)]'
        select '着手中',from: 'task[status]'
        click_on '登録'
        expect(page).to have_content 'タイトル０'
        expect(page).to have_content 'コンテント０'
        expect(page).to have_content '2024-01-01'
        expect(page).to have_content '着手中'
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
        expect(task_list[0]).to have_content 'タイトル２'
        expect(task_list[1]).to have_content 'タイトル１'
      end
    end
    context '終了期限でソートするというリンクを押すと' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_on '終了期限'
        sleep(Capybara.default_max_wait_time)
        task_list = all('.task_row')
        binding.irb
        expect(task_list[0]).to have_content 'タイトル１'
        expect(task_list[1]).to have_content 'タイトル２'
      end
    end
  end
  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        visit tasks_path
        click_on '詳細', match: :first
        page.html
        expect(page).to have_content 'タイトル'
      end
    end
  end
end
