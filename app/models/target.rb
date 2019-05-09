class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 10

  belongs_to :user
  belongs_to :topic

  validates :user, presence: true
  validates :lng, presence: true
  validates :lat, presence: true
  validates :radius, presence: true
  validates :title, presence: true
  validates :topic, presence: true

  validate :target_limit_per_user

  def target_limit_per_user
    (user.targets.count >= MAX_TARGETS_PER_USER) && errors.add(
      :user, I18n.t('api.targets.create.limit_reached', limit: MAX_TARGETS_PER_USER).to_s
    )
  end
end
