class Airplain < ApplicationRecord
  has_many :flights, dependent: :nullify
end
