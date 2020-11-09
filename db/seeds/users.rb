User.find_or_create_by(id: Rails.configuration.xo_monster['id']) do |u|
  u.name = Rails.configuration.xo_monster['name']
  u.email = Rails.configuration.xo_monster['email']
  u.password = Rails.configuration.xo_monster['password']
end.save(validate: false)

User.find_or_create_by(email: 'test@gmail.com') do |u|
  u.name = 'Tester'
  u.password = 'password'
end
