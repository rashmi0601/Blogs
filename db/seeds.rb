# db/seeds.rb
admin = User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.role = 'admin'
  end
  puts "Admin user created: #{admin.email}" if admin.persisted?
  