class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    enum status: { 未着手: "未着手", 着手中: "着手中", 完了: "完了" }
    # scope :title_and_status_search, -> (task){where('title LIKE ? AND status LIKE ?', "%#{task[:title]}%", "#{task[:status]}")}
    scope :title_search, -> (title){where('title LIKE ?', "%#{title}%")}
    scope :status_search, -> (status){where('status LIKE ?', "#{status}")}
end
