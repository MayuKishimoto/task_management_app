class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    enum status: { 未着手: "未着手", 着手中: "着手中", 完了: "完了" }
end
