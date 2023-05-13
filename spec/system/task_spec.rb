require "rails_helper"
RSpec.describe "タスク管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }

  before do
    visit new_session_path
    fill_in 'Email', with: 'ippan@ippan.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

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
      click_on 'タスク一覧'
    end
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        current_path
        Task.count
        page.html
        expect(page).to have_content 'タイトル１'
        expect(page).to have_content 'タイトル２'
        expect(page).to have_content 'タイトル３'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル３'
        expect(task_list[1]).to have_content 'タイトル２'
        expect(task_list[2]).to have_content 'タイトル１'
      end
    end
    context '終了期限でソートするというリンクを押すと' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_on '終了期限'
        sleep(Capybara.default_max_wait_time)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル３'
        expect(task_list[1]).to have_content 'タイトル２'
        expect(task_list[2]).to have_content 'タイトル１'
      end
    end
    context '優先順位でソートするというリンクを押すと' do
      it '優先順位の降順に並び替えられたタスク一覧が表示される' do
        click_on '優先順位'
        sleep(Capybara.default_max_wait_time)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル３'
        expect(task_list[1]).to have_content 'タイトル２'
        expect(task_list[2]).to have_content 'タイトル１'
      end
    end
  end

  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        click_on 'タスク一覧'
        click_on '詳細', match: :first
        page.html
        expect(page).to have_content 'タイトル'
      end
    end
  end
  
  describe '検索機能' do
    before do
      click_on 'タスク一覧'
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task[title]', with: 'タイトル１'
        click_on '検索'
        expect(page).to have_content 'タイトル１'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中',from: 'task[status]'
        click_on '検索'
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'task[title]', with: 'タイトル３'
        select '完了',from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'タイトル３'
        expect(page).to have_content '完了'
      end
    end
  end
end
