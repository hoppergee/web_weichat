# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_name = ["乔峰","虚竹","段誉","王语嫣","王夫人","慕容复","包三哥","叶二娘","少林方丈","段正淳","全冠清"]

users_name.each_with_index do |name, index|
	User.create!(username: name, email: "#{index}@qq.com", password: "123456")
end

users = User.all
u1 = User.first
users.each do |user|
	if u1 != user
		u1.request_friendship_with(user)
		user.accept_friendship_with(u1)
	end
end