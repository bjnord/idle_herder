class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_many :accounts, inverse_of: :user, dependent: :destroy
  validates :accounts, length: { minimum: 1 }
  ROLES = {'admin' => 'Admin', 'user' => 'User'}
  validates :role, presence: true, inclusion: { in: ROLES.keys, allow_blank: true }
  validate :validate_invite, on: :create

  before_validation :ensure_user_has_an_account

  attr_accessor :player_name
  attr_accessor :invitation_code
  def admin? ; self.role == 'admin' ; end

  def self.role_select_options
    ROLES.collect{|k,v| [v, k] }
  end

private

  def ensure_user_has_an_account
    if self.accounts.length < 1
      self.player_name ||= 'Unregistered #1'
      self.accounts << Account.new(player_name: self.player_name)
    end
  end

  def validate_invite
    return unless Rails.env.production?
    if self.invitation_code != "C#{rand(999999999).to_s.rjust(9, '0')}"
      errors.add(:invitation_code, 'is invalid')
    end
  end
end
