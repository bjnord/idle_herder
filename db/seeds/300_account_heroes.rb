AccountHero.destroy_all

user = User.find_by!(email: 'admin@example.com')
account = user.accounts.select {|a| a.player_name == 'Blue Meanie' }.first

hero = Hero.find_by!(name: 'Aidan', stars: 7)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 140, shards: 0, is_fodder: false, target_stars: 10)

###
# Death Orc (user@example.com)
###

user = User.find_by!(email: 'user@example.com')
account = user.accounts.select {|a| a.player_name == 'Death Orc' }.first

## Leveled Heroes

hero = Hero.find_by!(name: 'Gusta', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 100, shards: 0, is_fodder: false, target_stars: 6)
hero = Hero.find_by!(name: 'Dragon Slayer', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 100, shards: 0, is_fodder: false, target_stars: 6)
hero = Hero.find_by!(name: 'Fat Mu', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 80, shards: 0, is_fodder: true, target_stars: 5)
hero = Hero.find_by!(name: 'Starlight', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 80, shards: 0, is_fodder: false, target_stars: 6)
hero = Hero.find_by!(name: 'Thale', stars: 4)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 1, shards: 0, is_fodder: true, target_stars: 4)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 1, shards: 0, is_fodder: true, target_stars: 4)
# 3-star (and below) heroes are always considered fodder
hero = Hero.find_by!(name: 'Forests Captain', stars: 3)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 1, shards: 0, target_stars: 3)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 1, shards: 0, target_stars: 3)

## Specific Sharded Heroes

hero = Hero.find_by!(name: 'Starlight', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 0, shards: 50, is_fodder: true)
hero = Hero.find_by!(name: 'Thale', stars: 4)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 0, shards: 60, is_fodder: true)
# 3-star (and below) heroes are always considered fodder
hero = Hero.find_by!(name: 'Forests Captain', stars: 3)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, level: 0, shards: 40)

## Generic Sharded Heroes

account.account_heroes.create!(type: 'GenericAccountHero', g_stars: 4, shards: 30)
account.account_heroes.create!(type: 'GenericAccountHero', g_stars: 4, g_faction: 4, shards: 15)
account.account_heroes.create!(type: 'GenericAccountHero', g_stars: 5, shards: 30)
account.account_heroes.create!(type: 'GenericAccountHero', g_stars: 5, g_faction: 0, shards: 40)

## Wish List Heroes

hero = Hero.find_by!(name: 'Iceblink', stars: 6)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, wish_list: true, level: 0, shards: 0, target_stars: 10)
hero = Hero.find_by!(name: 'Ormus', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, wish_list: true, level: 0, shards: 0, target_stars: 6)
hero = Hero.find_by!(name: 'Queen', stars: 5)
account.account_heroes.create!(type: 'SpecificAccountHero', hero_id: hero.id, wish_list: true, level: 0, shards: 0, target_stars: 6)
