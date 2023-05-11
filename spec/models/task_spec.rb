require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '', content: '失敗テスト', user_id: user.id )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '', user_id: user.id )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '失敗テスト', content: '失敗テスト', user_id: user.id )
        expect(task).to be_valid
      end
    end
  end
  
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search('タイトル１')).to include(task)
        expect(Task.title_search('タイトル１')).not_to include(second_task)
        expect(Task.title_search('タイトル').count).to eq 3
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('未着手')).to include(task)
        expect(Task.status_search('未着手')).not_to include(second_task)
        expect(Task.status_search('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_search('タイトル１').status_search('未着手')).to include(task)
        expect(Task.title_search('タイトル１').status_search('未着手')).not_to include(second_task)
        expect(Task.title_search('タイトル').status_search('未着手').count).to eq 1
      end
    end
  end
end