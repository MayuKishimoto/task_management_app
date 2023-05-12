class Task < ApplicationRecord
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
    validates :title, presence: true
    validates :content, presence: true
    enum status: { 未着手: "未着手", 着手中: "着手中", 完了: "完了" }
    enum priority: { 高: 3, 中: 2, 低: 1 }
    scope :title_search, -> (title){where('title LIKE ?', "%#{title}%")}
    scope :status_search, -> (status){where('status LIKE ?', "#{status}")}
    scope :label_search, -> (label_ids){where(id: Labelling.where(label_id: label_ids).pluck(:task_id))}
    paginates_per 10
    belongs_to :user
end
