if ARGV[0]
require 'JSON'


command = ARGV[0]
key = ARGV[1]
if ARGV[2] 
	stat = ARGV[2]
end
if ARGV[3]
	value = ARGV[3]
end



emptyunit = '{
			"hppl": 50.0,
			"bhp": 450.0,
			"bad": 50.0,
			"adpl": 1.0,
			"bms": 500.0,
			"bar": 20.0,
			"arpl": 0.0,
			"bas": 100.0,
			"aspl": 2.0,
			"bmr": 20.0,
			"mrpl": 0.0,
			"bhr": 1.4,
			"hrpl": 0.1
		}'

commands = {}
	commands["addunit"] = "1 arg. Creates a new unit with the specified name. Case must match!"
	commands["removeunit"] = "1 arg. Removes a specified unit. Careful when using this command!"
	commands["changestat"] = "3 arg: key, stat, value. Changes the <stat> of <key> unit to <value>."
	commands["printallunits"] = "Prints all units on the screen."
	commands["printunitstats"] = "1 arg. Prints stat of specified unit."
	commands["help"] = "Shows this command"



File.open('./jsondata.json') do |f|
	js = JSON.parse(f.read)
		
	#backup the current JSON

		temps = Time.now.to_s
		temps.gsub!(/[ :]/, '-').chop!.chop!.chop!.chop!.chop!.chop!
		#File.open("jsondata_"+temps+".json", "w") do |buf|
		#	buf.write(JSON.pretty_generate(js))
		#end

	#backup block ends here
		
	if command == "addunit"
		File.open("backup_jsondata_"+temps+".json", "w") do |buf|
			buf.write(JSON.pretty_generate(js))
		end
		js["unit"][key] = JSON.parse(emptyunit)
		File.open("jsondata.json","w") do |nf|
			nf.write(JSON.pretty_generate(js))
		end
	end
	if command == "removeunit"
		File.open("jsondata_"+temps+".json", "w") do |buf|
			buf.write(JSON.pretty_generate(js))
		end
		if js["unit"].delete(key)
			File.open("jsondata.json","w") do |nf|
				nf.write(JSON.pretty_generate(js))
			end
		else
			print 'Unit "', key, '" not found! Not deleting.'
		end
	end
	if command == "changestat"
		File.open("jsondata_"+temps+".json", "w") do |buf|
			buf.write(JSON.pretty_generate(js))
		end
		js["unit"][key][stat] = value.to_f
		File.open("jsondata.json","w") do |nf|
			nf.write(JSON.pretty_generate(js))
		end
	end
	if command == "printallunits"
		js["unit"].each_key do |u|
			p u
		end
	end
	if command == "printunitstats"
		js["unit"][key].each do |s|
			p s
		end
	end
	if command == "help"
		if ARGV[1]
			print key, ": ", commands[key]
		else
			commands.each_key do |k|
				p k
			end
		end
	end
end

else
	p "Add argument 'help' to get available commands!"
end