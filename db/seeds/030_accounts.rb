Account.destroy_all

admin = User.find_by(email: 'admin@example.com')
admin.accounts.create!(player_name: 'Blue Meanie')

user = User.find_by(email: 'user@example.com')
user.accounts.create!(player_name: 'Death Orc')
user.accounts.create!(player_name: 'Evil Elf')
