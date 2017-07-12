# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_name = ["乔峰","虚竹","段誉","王语嫣","王夫人","慕容复","包三哥","叶二娘","少林方丈",
				"段正淳","全冠清","丁春秋","云中鹤","刀白凤","天山童姥","岳老三","康敏","慕容博",
				"扫地僧","无崖子","木婉清","李秋水","段延庆","游坦之","甘宝宝","秦红棉","苏星河",
				"萧远山","钟林","阮星竹","阿朱","阿紫","鸠摩智"]

users_name.each_with_index do |name, index|
	u = User.create!(username: name, 
					email: "#{index}@qq.com", 
					password: "123456",
					avatar: open(URI::escape("http://ors0wuao2.bkt.clouddn.com/image/webweichat/#{name}.png")))

	puts "(#{index+1})#{u.username}创建完毕"
end
