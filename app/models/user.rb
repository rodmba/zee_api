# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  validates :email, presence: true
  validates :email, uniqueness: true

  def downcase_email
    self.email = email.delete(" ").downcase
  end
end
