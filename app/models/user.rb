class User < ApplicationRecord
  has_secure_password
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: {with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}
  before_save :downcase_email

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  private
    def downcase_email
      self.email.downcase!
    end
end
