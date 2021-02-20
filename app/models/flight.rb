class Flight < ApplicationRecord
  belongs_to :airplain
  has_many :seats, dependent: :destroy
  has_many :passengers, dependent: :nullify
  has_one :flight_execution

  validates :airplain_id, presence: true
  
  validates :origin, :destination, :duration, presence: true

  validates :time, presence: true
  # greater that present 
  validates :date, presence: true

  validate :minimum_duration

  private

  def minimum_duration
    if duration < 30 
      errors.add(:duration, "can't be less than 30 min")
    end
  end

end