class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  ROLES = %w[admin user]
  validates :role, presence: true, inclusion: { in: ROLES, allow_blank: true }

  def admin? ; self.role == 'admin' ; end
end
