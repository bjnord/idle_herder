if account_hero.hero
  json.(account_hero.hero, :id, :name, :stars, :faction, :role, :max_level, :max_shards, :natural)
  json.box_type (account_hero.shards > 0) ? 'hero-shards' : ((account_hero.level > 0) ? 'hero' : 'wish-list')
  json.image_file "heroes/#{account_hero.hero.image_file}"
elsif account_hero.shard_type
  json.(account_hero.shard_type, :id, :stars, :faction)
  json.box_type 'generic-shards'
  json.image_file "shards/#{account_hero.shard_type.image_file}"
end
json.account_hero_id account_hero.id
json.(account_hero, :level, :shards, :priority, :is_fodder)
