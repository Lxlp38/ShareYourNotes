class Ban < ApplicationRecord
  belongs_to :user

  validates :start, presence: true
  validates :end, presence: true
  validates :reason, presence: true

  scope :active, -> { where(active: true) }
end
