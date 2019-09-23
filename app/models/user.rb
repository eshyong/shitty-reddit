class User < ApplicationRecord
  has_secure_password
  has_secure_password :recovery_password, validations: false

  validates :name, presence: true, length: { minimum: 1 }, uniqueness: true
end
