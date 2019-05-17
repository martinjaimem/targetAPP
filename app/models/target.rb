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

  def target_limit_per_user
    return unless user.targets.count >= MAX_TARGETS_PER_USER

    errors.add(:user, I18n.t('api.targets.create.limit_reached', limit: MAX_TARGETS_PER_USER))
  end

  def list_related_targets
    related_targets do |target|
      location = [target.lat, target.lng]
      dist = distance_from(location, units: :miles)
      dist <= radius
    end
  end

  private

  def related_targets
    Target.where(topic_id: topic_id).where.not(user_id: user_id)
  end
end
