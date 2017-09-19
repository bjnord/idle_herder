AccountHero.destroy_all

user = User.find_by!(email: 'admin@example.com')
account = user.accounts.select {|a| a.player_name == 'Blue Meanie' }.first

hero = Hero.find_by!(name: 'Aidan', stars: 7)
account.account_heroes.create!(hero_id: hero.id, level: 140, shards: 0, is_fodder: false, target_stars: 10)

###

user = User.find_by!(email: 'user@example.com')
account = user.accounts.select {|a| a.player_name == 'Death Orc' }.first

hero = Hero.find_by!(name: 'Gusta', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 100, shards: 0, is_fodder: false, target_stars: 6)
hero = Hero.find_by!(name: 'Dragon Slayer', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 100, shards: 0, is_fodder: false, target_stars: 6)
hero = Hero.find_by!(name: 'Fat Mu', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 80, shards: 0, is_fodder: true, target_stars: 5)
hero = Hero.find_by!(name: 'Starlight', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 0, shards: 40, is_fodder: true, target_stars: 5)
hero = Hero.find_by!(name: 'Iceblink', stars: 6)
account.account_heroes.create!(hero_id: hero.id, wish_list: true, level: 0, shards: 0, is_fodder: true, target_stars: 10)
hero = Hero.find_by!(name: 'Ormus', stars: 6)
account.account_heroes.create!(hero_id: hero.id, wish_list: true, level: 0, shards: 0, is_fodder: true, target_stars: 10)
hero = Hero.find_by!(name: 'Queen', stars: 6)
account.account_heroes.create!(hero_id: hero.id, wish_list: true, level: 0, shards: 0, is_fodder: true, target_stars: 10)
