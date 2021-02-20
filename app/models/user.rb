class User < ApplicationRecord
  has_many :passengers, dependent: :destroy
end
