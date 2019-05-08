# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Topic, type: :model do
  context 'is a valid instance' do
    subject { build(:topic) }
    it { is_expected.to validate_uniqueness_of(:label) }
    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  context 'isnt a valid instance' do
    context 'doesnt have label' do
      topic = Topic.new
      subject { topic }
      it { is_expected.to validate_presence_of(:label) }
    end
  end
end
