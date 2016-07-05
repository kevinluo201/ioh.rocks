require 'awesome_print'

# please install `mysql` gem
require 'mysql'

# general setting
mysql_host = "localhost"
mysql_user = "root"
mysql_pw   = "root"
ioh_db     = "ioh"
new_db     = "ioh-cover-maker_development"

result_data = []

#
# move talk start
#
begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, ioh_db

	result = con.query "SELECT ID, post_title, post_name
											FROM wp_posts
											WHERE post_type = 'talk'
											AND post_status = 'publish'"

	result.num_rows.times do
		row = result.fetch_row
		row[1] = row[1].gsub(/[']/, "\"")

		# result_data.push result.fetch_row[0].gsub(/[']/, "\"")
		result_data.push({ id: row[0], title: row[1], name: row[2] })
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, new_db

	result_data.each do |row|
		con.query "INSERT INTO `talks`
							 (`ioh_id`, `title`, `post_name`) 
							 VALUES 
							 (#{row[:id]}, '#{row[:title]}', '#{row[:name]}')"
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

talks = result_data
result_data = []


#
# move school start
#
begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, ioh_db

	result = con.query "SELECT t.name
							 FROM wp_terms AS t 
							 INNER JOIN wp_term_taxonomy AS tt
							 ON t.term_id = tt.term_id
							 WHERE tt.taxonomy IN ('school')
							 AND tt.parent != '0'"

	result.num_rows.times do
		result_data.push result.fetch_row[0].gsub(/[']/, "\"")
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, new_db

	result_data.uniq!

	result_data.each do |name|
		con.query "INSERT INTO `live_schools`
							 (`name`) VALUES ('#{name}')"
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

result_data = []


#
# move topic start
#
begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, ioh_db

	result = con.query "SELECT t.name
							 FROM wp_terms AS t 
							 INNER JOIN wp_term_taxonomy AS tt
							 ON t.term_id = tt.term_id
							 WHERE tt.taxonomy IN ('topic')
							 AND tt.parent != '0'"

	result.num_rows.times do
		result_data.push result.fetch_row[0].gsub(/[']/, "\"")
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end


begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, new_db

	result_data.uniq!

	result_data.each do |name|
		con.query "INSERT INTO `live_departments`
							 (`name`) VALUES ('#{name}')"
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

result_data = []

#
# get school relations
#
begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, ioh_db

	talks.each do |talk|
		result = con.query "SELECT t.name
												FROM `wp_terms` as t
												INNER JOIN `wp_term_taxonomy` as tt
												ON tt.`term_id` = t.`term_id`
												AND tt.`taxonomy` = 'school'
												AND tt.`parent` IN (4, 9, 40, 289, 316)
												INNER JOIN `wp_term_relationships` as r
												ON r.term_taxonomy_id = tt.term_taxonomy_id 
												AND r.`object_id` IN (#{talk[:id]})"

		result_data.push  result.fetch_row
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

schools = result_data
result_data = []

begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, new_db

	schools.each do |school|
		if school
			result = con.query "SELECT `id`
													FROM `live_schools`
													WHERE `name` = '#{school[0]}'"

			result_data.push result.fetch_row
		else
			result_data.push nil
		end
	end

	result_data.each_index do |index|
		if result_data[index]
			result = con.query "UPDATE `talks`
	  							 				SET `live_school_id` = #{result_data[index][0]}
	  							 				WHERE `id` = #{index + 1}"
		end
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

result_data = []

#
# get topic relations
#
begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, ioh_db

	talks.each do |talk|
		result = con.query "SELECT t.name
												FROM `wp_terms` as t
												INNER JOIN `wp_term_taxonomy` as tt
												ON tt.`term_id` = t.`term_id`
												AND tt.`taxonomy` = 'topic'
												AND tt.`parent` IN (12, 13, 14, 147, 148, 149)
												INNER JOIN `wp_term_relationships` as r
												ON r.term_taxonomy_id = tt.term_taxonomy_id 
												AND r.`object_id` IN (#{talk[:id]})"

		result_data.push  result.fetch_row
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

topics = result_data
result_data = []

begin

	# start connection to ioh
	con = Mysql.new mysql_host, mysql_user, mysql_pw, new_db

	topics.each do |topic|
		if topic
			result = con.query "SELECT `id`
													FROM `live_departments`
													WHERE `name` = '#{topic[0]}'"


			result_data.push result.fetch_row
		else
			result_data.push nil
		end
	end

	result_data.each_index do |index|
		result = con.query "UPDATE `talks`
  							 				SET `live_department_id` = #{result_data[index][0]}
  							 				WHERE `id` = #{index + 1}"
	end

	rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
	ensure
	    con.close if con
end

result_data = []