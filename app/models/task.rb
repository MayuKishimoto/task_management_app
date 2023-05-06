class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    enum status: { 未着手: "未着手", 着手中: "着手中", 完了: "完了" }
    # scope :where_title_and_status, -> (task){where('title LIKE ? AND status LIKE ?', "%#{task[:title]}%", "#{task[:status]}")}
    scope :where_title_like, -> (task){where('title LIKE ?', "%#{task[:title]}%")}
    scope :where_status_like, -> (task){where('status LIKE ?', "#{task[:status]}")}
end
