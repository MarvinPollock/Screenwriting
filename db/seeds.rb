# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1.times do
    @group = Group.new  
    @group.num = 2
    @group.status = "Frei"
    10.times do
    name = Faker::Name
    user = User.create!(
      first_name: name.first_name,
      last_name: name.last_name,
      email: Faker::Internet.email,
      identifier_url: 'openid.example.com/' + name.name.downcase.gsub(/\W/,'_'),
      role: "student")
      @group.users << user
  end
  @group.save
end

5.times do
    name = Faker::Name
    user = User.create!(
      first_name: name.first_name,
      last_name: name.last_name,
      email: Faker::Internet.email,
      identifier_url: 'openid.example.com/' + name.name.downcase.gsub(/\W/,'_'),
      role: "student")
end
