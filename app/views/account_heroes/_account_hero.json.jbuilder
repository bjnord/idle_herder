json.(account_hero, :box_type, :name, :stars, :max_stars, :faction, :shards, :max_shards, :priority, :asset_path)
json.is_natural account_hero.natural? ? true : false
json.is_fodder account_hero.fodder? ? true : false
json.account_hero_id account_hero.id
if account_hero.specific?
  json.(account_hero, :level, :max_level, :target_stars, :role)
  json.id account_hero.hero.id
end
