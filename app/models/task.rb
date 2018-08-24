class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :duedate, presence: true 
  validates :priority, numericality: { only_integer: true }
end
