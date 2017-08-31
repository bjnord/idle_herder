class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
end
