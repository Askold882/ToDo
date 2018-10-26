require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  context 'valid' do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:priority).only_integer }
    it { should validate_presence_of(:duedate) }
    it { should_not allow_value("-2014/Aprilol/15000").for(:duedate) }
  end
end