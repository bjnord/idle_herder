class Account < ApplicationRecord
  belongs_to :user, inverse_of: :accounts
  belongs_to :icon_hero, optional: true, class_name: 'Hero', foreign_key: :icon_hero_id
  has_many :account_heroes, dependent: :destroy
  validates :player_name, presence: true
  validates :player_id, format: { with: /\A\d+\z/ }, unless: Proc.new {|a| a.player_id.blank? }
end
