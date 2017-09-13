# FIXME might have account_hero.shard_type and no account_hero.hero
json.(account_hero.hero, :id, :name, :stars, :faction, :role, :image_file, :natural)
json.account_hero_id account_hero.id
json.(account_hero, :level, :shards, :priority, :is_fodder)
