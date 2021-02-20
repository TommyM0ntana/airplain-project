class Flight < ApplicationRecord
  belongs_to :airplain
  has_many :seats, dependent: :destroy
  has_many :passengers, dependent: :nullify
  has_one :flight_execution

  validates :airplain_id, presence: true
  validates :origin, :destination, :duration, :time, :date, presence: true
  validate :minimum_duration
  validate :date_validity

  private

  def date_validity
    if date && (date < Date.today)
      errors.add(:date, "can't be before today")
    end
  end

  def minimum_duration
    if duration && (duration < 30)
      errors.add(:duration, "can't be less than 30 min")
    end
  end

end