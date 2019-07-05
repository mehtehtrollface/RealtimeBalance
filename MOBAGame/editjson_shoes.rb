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




emptyunit = JSON.parse('{"hppl": 50.0,"bhp": 450.0,"bad": 50.0,"adpl": 1.0,"bms": 500.0,"bar": 20.0,"arpl": 0.0,"bas": 100.0,"aspl": 2.0,"bmr": 20.0,"mrpl": 0.0,"bhr": 1.4,"hrpl": 0.1,"rname": "Mana","bres": 200.0,"brr": 5.0,"respl": 50.0,"rrpl": 0.5}')
	
	
	
		
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

Shoes.app(title: "MOBAGame Realtime Balance", width: 1200, height: 600) do
	

	
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
			@unitselect = list_box items: templist, height: 20
			@delunitb = button "Delete unit"
		end
		
		para " "
		
		flow do 
			#Base values
			stack(width:300) do
			
				#Health Points
				flow(margin:3) do
					para "Base Health "
					@bhpl = edit_line(width:60)
				end
				
				#Attack Damage
				flow(margin:3) do
					para "Base Attack Damage "
					@badl = edit_line(width:60)
				end
				
				#Armor
				flow(margin:3) do
					para "Base Armor "
					@barl = edit_line(width:60)
				end
				
				#Magic Resist
				flow(margin:3) do
					para "Base Magic Resist "
					@bmrl = edit_line(width:60)
				end
				
				#Attack Speed
				flow(margin:3) do
					para "Base Attack Speed "
					@basl = edit_line(width:60)
				end
				
				#Health Regen
				flow(margin:3) do
					para "Base Health Regen "
					@bhrl = edit_line(width:60)
				end
				
				#Movement Speed
				flow(margin:3) do
					para "Base Movespeed "
					@bmsl = edit_line(width:60)
				end
			end
			
			#Per level values
			stack(width:300) do
				#Health Points
				flow(margin:3) do
					para "Health per level "
					@hppll = edit_line(width:60) 
				end
				
				#Attack Damage
				flow(margin:3) do
					para "Attack Damage per level "
					@adpll = edit_line(width:60) 
				end
				
				#Armor
				flow(margin:3) do
					para "Armor per level "
					@arpll = edit_line(width:60) 	
				end
				
				#Magic Resist
				flow(margin:3) do
					para "MR per level "
					@mrpll = edit_line(width:60) 
				end
				
				#Attack Speed
				flow(margin:3) do
					para "AS per level "
					@aspll = edit_line(width:60) 
				end
				
				#Health Regen
				flow(margin:3) do
					para "HRegen per level "
					@hrpll = edit_line(width:60) 
				end
			end
		end
		
		
		
		para "Heroes only: "
		
		flow do 
			#Base Values
			stack(width:300) do
			
				#Resource Name
				flow(margin:3) do
					para "Resource Name "
					@rnamel = edit_line(width:100)
				end
				
				#Resource
				flow(margin:3) do
					para "Base Resource "
					@bresl = edit_line(width:60)
				end
				
				#Resource Regen
				flow(margin:3) do
					para "Base Resource Regen "
					@brrl = edit_line(width:60)
				end
			end
			
			#Per Level
			stack(width:300) do
				para " "
				
				#Resource
				flow(margin:3) do
					para "Resource per level "
					@respll = edit_line(width:60)
				end
				
				#Resource Regen
				flow(margin:3) do
					para "RRegen per level "
					@rrpll = edit_line(width:60)
				end
			end
		end
		
		
		
		
		#When a new unit is selected, change displayed stats
		@unitselect.change do |selection|
			selectedunit = selection.text
			@bhpl.text = js["unit"][selectedunit]["bhp"]
			@badl.text = js["unit"][selectedunit]["bad"]
			@barl.text = js["unit"][selectedunit]["bar"]
			@bmrl.text = js["unit"][selectedunit]["bmr"]
			@basl.text = js["unit"][selectedunit]["bas"]
			@bhrl.text = js["unit"][selectedunit]["bhr"]
			@bmsl.text = js["unit"][selectedunit]["bms"]
			@hppll.text = js["unit"][selectedunit]["hppl"]
			@adpll.text = js["unit"][selectedunit]["adpl"]
			@arpll.text = js["unit"][selectedunit]["arpl"]
			@mrpll.text = js["unit"][selectedunit]["mrpl"]
			@aspll.text = js["unit"][selectedunit]["aspl"]
			@hrpll.text = js["unit"][selectedunit]["hrpl"]
			@rnamel.text = js["unit"][selectedunit]["rname"]
			@bresl.text = js["unit"][selectedunit]["bres"]
			@brrl.text = js["unit"][selectedunit]["brr"]
			@respll.text = js["unit"][selectedunit]["respl"]
			@rrpll.text = js["unit"][selectedunit]["rrpl"]
		end

		
		
		
		
		
		@addunitb.click do 
			js = add_unit @newunitl.text, emptyunit, js
			templist = update_templist js
			@unitselect.items = templist
			@unitselect.choose js["unit"][0]
		end
		
		
		@delunitb.click do
			js = del_unit @unitselect.text, js
			templist = update_templist js
			@unitselect.items = templist
			@unitselect.choose js["unit"][0]
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

