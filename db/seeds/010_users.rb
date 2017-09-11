User.destroy_all
User.create!(email: 'admin@example.com', role: 'admin', password: 'fluffy!!', password_confirmation: 'fluffy!!', confirmed_at: Time.now)
User.create!(email: 'user@example.com', role: 'user', password: 'lemony??', password_confirmation: 'lemony??', confirmed_at: Time.now)
