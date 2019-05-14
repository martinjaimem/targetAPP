# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Topic, type: :model do
  let(:topic) { build(:topic) }

  subject { topic }

  context 'validations' do
    it { is_expected.to validate_presence_of(:label) }
  end
end
