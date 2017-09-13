AccountHero.destroy_all

user = User.find_by!(email: 'admin@example.com')
account = user.accounts.select {|a| a.player_name == 'Blue Meanie' }.first

hero = Hero.find_by!(name: 'Aidan', stars: 7)
account.account_heroes.create!(hero_id: hero.id, level: 140, shards: 0, is_fodder: false)

###

user = User.find_by!(email: 'user@example.com')
account = user.accounts.select {|a| a.player_name == 'Death Orc' }.first

hero = Hero.find_by!(name: 'Gusta', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 100, shards: 0, is_fodder: false)
hero = Hero.find_by!(name: 'Fat Mu', stars: 5)
account.account_heroes.create!(hero_id: hero.id, level: 80, shards: 0, is_fodder: true)
# FIXME populate some sharded and wish-list heroes
