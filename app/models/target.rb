# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  radius     :decimal(, )
#  lat        :float
#  lng        :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  topic_id   :bigint
#

class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 10

  acts_as_mappable default_units: :miles,
                   default_formula: :flat,
                   distance_field_name: :distance,
                   lat_column_name: :lat,
                   lng_column_name: :lng

  belongs_to :user
  belongs_to :topic

  validates :user, :lng, :lat, :radius, :title, :topic, presence: true

  validate :target_limit_per_user

  after_create :notify_matched_users

  scope :not_of_user, ->(user_id) { where.not(user_id: user_id) }

  def target_limit_per_user
    return unless user.targets.count >= MAX_TARGETS_PER_USER

    errors.add(:user, I18n.t('api.targets.create.limit_reached', limit: MAX_TARGETS_PER_USER))
  end

  def notify_matched_users
    targets_users.each do |matched_user|
      NotificationsJob.perform_later(
        [matched_user.push_token], I18n.t('api.targets.notification.match'),
        username: matched_user.username
      )
    end
  end

  private

  def related_targets
    candidate_targets = topic.targets.not_of_user(user_id)
    candidate_targets.select do |candidate_target|
      intersects?(candidate_target)
    end
  end

  def targets_users
    related_targets.map(&:user)
  end

  def intersects?(candidate_target)
    location = [candidate_target.lat, candidate_target.lng]
    dist = distance_from(location, units: :miles)
    dist <= candidate_target.radius + radius
  end
end
