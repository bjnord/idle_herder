class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_many :accounts, inverse_of: :user, dependent: :destroy
  ROLES = %w[admin user]
  validates :role, presence: true, inclusion: { in: ROLES, allow_blank: true }
  validate :validate_invite, on: :create

  attr_accessor :invitation_code
  def admin? ; self.role == 'admin' ; end

  def validate_invite
    return unless Rails.env.production?
    if self.invitation_code != "C#{rand(999999999).to_s.rjust(9, '0')}"
      errors.add(:invitation_code, 'is invalid')
    end
  end
end
