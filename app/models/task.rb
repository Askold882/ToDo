class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :duedate, presence: true
  validate :duedate_cannot_be_in_the_past
  validates :priority, numericality: { only_integer: true }
  
  def duedate_cannot_be_in_the_past
    if duedate.present? && duedate.past?
      errors.add(:duedate, "can't be in the past")
    end
  end  

end
