class Airplain < ApplicationRecord
  has_many :flights, dependent: :nullify
  validates :model, :first_class, :executive_class, :economic_class, presence: true
end
