require 'JSON'

js = 0

File.open('./jsondata.json') do |f|
	js = JSON.parse(f.read)
end

templist = []

def update_templist jf
	tmp = []
	jf["unit"].each_key do |k|
		tmp.insert -1,k
	end
	return tmp
end




emptyunit = JSON.parse('{"hppl": 50.0,"bhp": 450.0,"bad": 50.0,"adpl": 1.0,"bms": 500.0,"bar": 20.0,"arpl": 0.0,"bas": 100.0,"aspl": 2.0,"bmr": 20.0,"mrpl": 0.0,"bhr": 1.4,"hrpl": 0.1}')
	
	
	
		
def backup
	temps = Time.now.to_s
	temps.gsub!(/[ :]/, '-').chop!.chop!.chop!.chop!.chop!.chop!
	File.open("jsondata.json") do |currentjson|
		File.open("jsondata_"+temps+".json", "w") do |buf|
			buf.write(currentjson.read)
		end
	end
end



def save_changes(jsondata)
	File.open("jsondata.json","w") do |nf|
		nf.write(JSON.pretty_generate(jsondata))
	end
end



def add_unit(name, eu, jf)
	jf["unit"][name] = eu
	return jf
end



def del_unit(name, jf)
	if not jf["unit"].delete(name)
		print 'Unit "', name, '" not found! No action done.'
	end
	return jf
end





selectedunit = "yeet"

templist = update_templist js

Shoes.app(title: "MOBAGame Realtime Balance", width: 800, height: 600) do
	

	
	background white

	stack(margin:8) do
	
		change = false
		flow(margin:8) do
			@saveb = button "Save changes", size:50
			para "Add a new unit: "
			@newunitl = edit_line(width:120)
			@addunitb = button "Add"
		end
		
		
		flow do
			para "Unit: "
			@unitbox = list_box items: templist 
			@delunitb = button "Delete unit"
		end
		
		@addunitb.click do 
			js = add_unit @newunitl.text, emptyunit, js
			templist = update_templist js
			@unitbox.items = templist
			@unitbox.choose js["unit"][0]
		end
		
		@delunitb.click do
			js = del_unit @unitbox.text, js
			templist = update_templist js
			@unitbox.items = templist
			@unitbox.choose js["unit"][0]
		end
		
		@saveb.click do
			backup
			save_changes js
		end
	end
	
end




command = ARGV[0]
key = ARGV[1]
if ARGV[2] 
	stat = ARGV[2]
end
if ARGV[3]
	value = ARGV[3]
end



commands = {}
	commands["addunit"] = "1 arg. Creates a new unit with the specified name. Case must match!"
	commands["removeunit"] = "1 arg. Removes a specified unit. Careful when using this command!"
	commands["changestat"] = "3 arg: key, stat, value. Changes the <stat> of <key> unit to <value>."
	commands["printallunits"] = "Prints all units on the screen."
	commands["printunitstats"] = "1 arg. Prints stat of specified unit."
	commands["help"] = "Shows this command"

if false



		

	if command == "removeunit"
		File.open("jsondata_"+temps+".json", "w") do |buf|
			buf.write(JSON.pretty_generate(js))
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

