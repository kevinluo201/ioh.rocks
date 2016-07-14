

schools = LiveSchool.create([
  { name: "嶺東科技大學" },
  { name: "馬偕醫學院" },
  { name: "聯合大學" },
  { name: "真理大學" },
  { name: "德明科技大學" },
  { name: "中信金融管理學院" }
])

departments = LiveDepartment.create([
	{ name: "美術與文創學系" },
	{ name: "能源工程學系" },
	{ name: "巨量資料管理學系" },
	{ name: "教育經營與管理學系" }
])


# r1 = Role.create({name: "Regular", description: "Can read items"})
# r2 = Role.create({name: "Editor", description: "Can read and create items. Can update and destroy own items"})
# r3 = Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})

# times = LiveTime.create([
# 		{start: DateTime.strptime("07/18/2016 6:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 6:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 7:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 7:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 8:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 12:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 12:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 13:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 13:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/18/2016 14:00", "%m/%d/%Y %H:%M")},

# 		{start: DateTime.strptime("07/19/2016 6:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 6:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 7:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 7:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 8:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 12:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 12:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 13:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 13:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/19/2016 14:00", "%m/%d/%Y %H:%M")},

# 		{start: DateTime.strptime("07/20/2016 6:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 6:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 7:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 7:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 8:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 12:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 12:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 13:00", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 13:30", "%m/%d/%Y %H:%M")},
# 		{start: DateTime.strptime("07/20/2016 14:00", "%m/%d/%Y %H:%M")},
# ])