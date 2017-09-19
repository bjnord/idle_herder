class ShardType < ApplicationRecord
  self.primary_key = 'id'

  validates :id, presence: true
  validates :id, numericality: { only_integer: true, greater_than: 0 }, unless: Proc.new {|st| st.id.blank? }
  validates :stars, presence: true
  validates :stars, numericality: { only_integer: true, greater_than_or_equal_to: 3, less_than_or_equal_to: 5 }, unless: Proc.new {|st| st.stars.blank? }
  validates :faction, inclusion: {in: (0..Hero::FACTIONS.count-1), message: 'is not valid'}, unless: Proc.new {|st| st.faction.blank? }

  def faction=(faction)
    super(faction.respond_to?(:to_str) ? Hero::FACTIONS.index(faction) : faction)
  end
  def faction_name
    Hero::FACTIONS[self.faction]
  end

  def max_shards
    Hero::MAX_SHARDS[stars]
  end
  def max_stars
    stars
  end

  def self.build_from_json(id)
    json = File.read(self.json_path(id))
    shard_type_h = JSON.parse(json)
    shard_type_h['image_file'] = shard_type_h.delete('img')
    shard_type = ShardType.new(shard_type_h)
    shard_type
  end

  def asset_path
    "shards/#{image_file}"
  end

protected

  def self.json_path(id)
    Rails.root.join('db', 'data', 'shard_types', "#{id}.json")
  end
end
