require "rails_helper"
RSpec.describe "タスク管理機能", type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'Title', with: 'タイトル'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'Content', with: 'コンテント'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'タイトル'
        expect(page).to have_content 'コンテント'
      end
    end
  end
  describe "一覧表示機能" do
    before do
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      visit tasks_path
    end
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        # # テストで使用するためのタスクを作成
        # task = FactoryBot.create(:task, title: 'task')
        # # タスク一覧ページに遷移
        # visit tasks_path
        # タスク一覧ページに遷移できているかを確認
        current_path
        # タスクがデータベースに作成されているかを確認
        Task.count
        # 表示するHTMLにタスク情報が入っているかを確認
        page.html
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
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
        # binding.irb
        click_on '詳細'
        # 表示するページにタスク情報が入っているかを確認
        page.html
        expect(page).to have_content 'task'
      end
    end
  end
end
