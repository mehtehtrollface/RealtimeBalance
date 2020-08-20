require 'JSON'

js = 0

File.open('./jsondata.json') do |f|
	js = JSON.parse(f.read)
end

templist = []
templistab = []

def update_templist_unit jf
	tmp = []
	jf["unit"].each_key do |k|
		tmp.insert -1,k
	end
	return tmp
end

def update_templist_ability jf
	tmp = []
	jf["ability"].each_key do |k|
		tmp.insert -1,k
	end
	return tmp
end




emptyunit = JSON.parse('{"hppl": 50.0,"bhp": 450.0,"bad": 50.0,"adpl": 1.0,"bms": 500.0,"bar": 20.0,"arpl": 0.0,"bas": 100.0,"aspl": 2.0,"bmr": 20.0,"mrpl": 0.0,"bhr": 1.4,"hrpl": 0.1,"rname": "Mana","bres": 200.0,"brr": 5.0,"respl": 50.0,"rrpl": 0.5}')
emptyability = JSON.parse('{"bval1": 0.0,"bval2": 0.0,"bval1pl": 0.0,"bval2pl": 0.0,"ratio1": 0.0,"ratio2": 0.0,"basecd": 10.0,"cdpl": 0.0,"rescost": 0.0,"rescostpl": 0.0,"recasts": 0,"recastcost": 0.0,"recastcd": 0.0,"recastto": 0.0,"ratio1type": "ap","ratio2type": "bad"}')
	
	
	
		
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
	alert "Added unit " + name
end


def add_ability(name, eu, jf)
	jf["ability"][name] = eu
	return jf
	alert "Added ability " + name
end



def del_unit(name, jf)
	if not jf["unit"].delete(name)
		print 'Unit "', name, '" not found! No action done.'
	end
	return jf
end

def del_ability(name, jf)
	if not jf["ability"].delete(name)
		print 'Ability "', name, '" not found! No action done.'
	end
	return jf
end



def update_save code
	
	# Change was made
	if code == 0
		saved = false
	end
	
	# Unit was changed
	if code == 1
		if saved 
			
		end
	end
	
	# JSON was saved
	if code == 2
		
	end
	if saved 
		@unsaved.text = " "
	else
		@unsaved.text = "You have unsaved changes!"
	end
end


saved=true

selectedunit = "yeet"

selectedability = "hneh"

templistab = update_templist_ability js

templist = update_templist_unit js

Shoes.app(title: "MOBAGame Realtime Balance", width: 800, height: 600) do
	

	
	background white
	
	@tabselect = list_box items: ["Abilities", "Units"], height: 20
	
	@unittab = stack(margin:8) do
	
		
		flow(margin:8) do
			@saveb = button "Save JSON", size:50
			para "Add a new unit: "
			@newunitl = edit_line(width:120)
			@addunitb = button "Add"
			@warningpara = para " ", stroke: red
		end
		
		#@unsaved = para " ", stroke: red
		
		
		
		flow do
			para "Unit: "
			@unitselect = list_box items: templist, height: 20
			@delunitb = button "Delete unit"
		end
		
		para "Note: In contrast to the code in the project, base values here are actually level 1 values!"
		
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
			
			@bhpl.text = js["unit"][selectedunit]["bhp"] + js["unit"][selectedunit]["hppl"]
			@badl.text = js["unit"][selectedunit]["bad"] + js["unit"][selectedunit]["adpl"]
			@barl.text = js["unit"][selectedunit]["bar"] + js["unit"][selectedunit]["arpl"]
			@bmrl.text = js["unit"][selectedunit]["bmr"] + js["unit"][selectedunit]["mrpl"]
			@basl.text = js["unit"][selectedunit]["bas"] + js["unit"][selectedunit]["aspl"]
			@bhrl.text = js["unit"][selectedunit]["bhr"] + js["unit"][selectedunit]["hrpl"]
			@bmsl.text = js["unit"][selectedunit]["bms"]
			@hppll.text = js["unit"][selectedunit]["hppl"]
			@adpll.text = js["unit"][selectedunit]["adpl"]
			@arpll.text = js["unit"][selectedunit]["arpl"]
			@mrpll.text = js["unit"][selectedunit]["mrpl"]
			@aspll.text = js["unit"][selectedunit]["aspl"]
			@hrpll.text = js["unit"][selectedunit]["hrpl"]
			@rnamel.text = js["unit"][selectedunit]["rname"]
			@bresl.text = js["unit"][selectedunit]["bres"] + js["unit"][selectedunit]["respl"]
			@brrl.text = js["unit"][selectedunit]["brr"] + js["unit"][selectedunit]["rrpl"]
			@respll.text = js["unit"][selectedunit]["respl"]
			@rrpll.text = js["unit"][selectedunit]["rrpl"]
			
		end

		
		@bhpl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bhp"] = tmpf - js["unit"][selectedunit]["hppl"]
		end
		
		@badl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bad"] = tmpf - js["unit"][selectedunit]["adpl"]
		end
		
		@barl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bar"] = tmpf - js["unit"][selectedunit]["arpl"]
		end
		
		@bmrl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bmr"] = tmpf - js["unit"][selectedunit]["mrpl"]
		end
		
		@basl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bas"] = tmpf - js["unit"][selectedunit]["aspl"]
		end
		
		@bhrl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bhr"] = tmpf - js["unit"][selectedunit]["hrpl"]
		end
		
		@bmsl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bms"] = tmpf
		end
		
		@hppll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bhp"] = js["unit"][selectedunit]["bhp"] + js["unit"][selectedunit]["hppl"]
			js["unit"][selectedunit]["hppl"] = tmpf
			js["unit"][selectedunit]["bhp"] = js["unit"][selectedunit]["bhp"] - tmpf
		end
		
		@adpll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bad"] = js["unit"][selectedunit]["bad"] + js["unit"][selectedunit]["adpl"]
			js["unit"][selectedunit]["adpl"] = tmpf
			js["unit"][selectedunit]["bad"] = js["unit"][selectedunit]["bad"] - tmpf
		end
		
		@arpll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bar"] = js["unit"][selectedunit]["bar"] + js["unit"][selectedunit]["arpl"]
			js["unit"][selectedunit]["arpl"] = tmpf
			js["unit"][selectedunit]["bar"] = js["unit"][selectedunit]["bar"] - tmpf
		end
		
		@mrpll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bmr"] = js["unit"][selectedunit]["bmr"] + js["unit"][selectedunit]["mrpl"]
			js["unit"][selectedunit]["mrpl"] = tmpf
			js["unit"][selectedunit]["bmr"] = js["unit"][selectedunit]["bmr"] - tmpf
		end
		
		@aspll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bas"] = js["unit"][selectedunit]["bas"] + js["unit"][selectedunit]["aspl"]
			js["unit"][selectedunit]["aspl"] = tmpf
			js["unit"][selectedunit]["bas"] = js["unit"][selectedunit]["bas"] - tmpf
		end
		
		@hrpll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bhr"] = js["unit"][selectedunit]["bhr"] + js["unit"][selectedunit]["hrpl"]
			js["unit"][selectedunit]["hrpl"] = tmpf
			js["unit"][selectedunit]["bhr"] = js["unit"][selectedunit]["bhr"] - tmpf
		end
		
		@rnamel.change do |block|
			tmpf = block.text
			js["unit"][selectedunit]["rname"] = tmpf
		end
		
		@bresl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bres"] = tmpf - js["unit"][selectedunit]["respl"]
		end
		
		@brrl.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["brr"] = tmpf - js["unit"][selectedunit]["rrpl"]
		end
		
		@respll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["bres"] = js["unit"][selectedunit]["bres"] + js["unit"][selectedunit]["respl"]
			js["unit"][selectedunit]["respl"] = tmpf
			js["unit"][selectedunit]["bres"] = js["unit"][selectedunit]["bres"] - tmpf
		end
		
		@rrpll.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["unit"][selectedunit]["brr"] = js["unit"][selectedunit]["brr"] + js["unit"][selectedunit]["rrpl"]
			js["unit"][selectedunit]["rrpl"] = tmpf
			js["unit"][selectedunit]["brr"] = js["unit"][selectedunit]["brr"] - tmpf
		end
		
		
		
		@addunitb.click do 
			js = add_unit @newunitl.text, emptyunit, js
			templist = update_templist_unit js
			@unitselect.items = templist
			@unitselect.choose js["unit"][0]
		end
		
		
		@delunitb.click do
			js = del_unit @unitselect.text, js
			templist = update_templist_unit js
			@unitselect.items = templist
			@unitselect.choose js["unit"][0]
		end
		
		
		@saveb.click do
			backup
			save_changes js
			@unsaved.text = " "
		end
		
	end
	
	
	
	
	
	
	#Abilities
	#-----------------------------------------------------------
	
	puts "Units fine"
	
	@abilitytab = stack(margin:8) do
	
		flow(margin:8) do
			@savebab = button "Save JSON", size:50
			para "Add a new ability: "
			@newabilityl = edit_line(width:120)
			@addabilityb = button "Add"
			@warningpara = para " ", stroke: red
		end
		
		flow do
			para "Ability: "
			@abilityselect = list_box items: templistab, height: 20
			@delabilityb = button "Delete ability"
		end
		
		para "Note: In contrast to the code in the project, base values here are actually level 1 values!"
		
		flow do 
			stack(width:300) do
				flow(width:300, margin:3) do
					para "Base Value 1 "
					@bval1 = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Base Value 2 "
					@bval2 = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Ratio Stat 1 "
					@ratio1type = list_box items: ["Max Health", "Total Attack Damage", "Ability Power", "Bonus Attack Damage", "Armor", "Magic Resist", "Health Regen", "Movespeed", "Attack Speed", "Lifesteal", "Spell Vamp", "Max Mana", "Mana Regen", "Armor Pen", "Magic Pen", "% Armor Pen", "% Magic Pen", "Cooldown Reduction", "Crit Chance", "Tenacity"], height: 20
					@ratio1type.choose "Ability Power"
				end
				flow(width:300, margin:3) do
					para "Ratio Stat 2 "
					@ratio2type = list_box items: ["Max Health", "Total Attack Damage", "Ability Power", "Bonus Attack Damage", "Armor", "Magic Resist", "Health Regen", "Movespeed", "Attack Speed", "Lifesteal", "Spell Vamp", "Max Mana", "Mana Regen", "Armor Pen", "Magic Pen", "% Armor Pen", "% Magic Pen", "Cooldown Reduction", "Crit Chance", "Tenacity"], height: 20
					@ratio2type.choose "Ability Power"
				end
				flow(width:300, margin:3) do
					para "Base Cooldown "
					@basecd = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Base Resource Cost "
					@rescost = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Recasts "
					@recasts = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Recast Cooldown "
					@recastcd = edit_line(width:60)
				end
			end
			stack(width:300) do	
				flow(width:300, margin:3) do
					para "Base Value 1 Per Level "
					@bval1pl = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Base Value 2 Per Level "
					@bval2pl = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Ratio 1 "
					@ratio1 = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Ratio 2 "
					@ratio2 = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Cooldown Change Per Level "
					@cdpl = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Cost Change Per Level "
					@rescostpl = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Recast Cost "
					@recastcost = edit_line(width:60)
				end
				flow(width:300, margin:3) do
					para "Recast Timeout "
					@recastto = edit_line(width:60)
				end
			end
		end
		
		@recasts.change do |block|
			tmpf = block.text.to_i
			js["ability"][selectedability]["recasts"] = tmpf
		end
		
		@recastcost.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["recastcost"] = tmpf
		end
		
		@recastto.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["ability"][selectedability]["recastto"] = tmpf
		end
		
		@recastcd.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["ability"][selectedability]["recastcd"] = tmpf
		end
		
		@bval1pl.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["bval1"] = js["ability"][selectedability]["bval1"] + js["ability"][selectedability]["bval1pl"]
			js["ability"][selectedability]["bval1pl"] = tmpf
			js["ability"][selectedability]["bval1"] = js["ability"][selectedability]["bval1"] - tmpf
		end
		
		@bval1.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["bval1"] = tmpf - js["ability"][selectedability]["bval1pl"]
		end
		
		@bval2pl.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["bval2"] = js["ability"][selectedability]["bval2"] + js["ability"][selectedability]["bval2pl"]
			js["ability"][selectedability]["bval2pl"] = tmpf
			js["ability"][selectedability]["bval2"] = js["ability"][selectedability]["bval2"] - tmpf
		end
		
		@bval2.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["bval2"] = tmpf - js["ability"][selectedability]["bval2pl"]
		end
		
		@cdpl.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["cdpl"] = tmpf
		end
		
		@basecd.change do |block|
			tmpf = block.text.to_f
			if tmpf == 0
				@warningpara.text = "Warning! You are setting a 0 value!"
			else
				@warningpara.text = " "
			end
			js["ability"][selectedability]["basecd"] = tmpf
		end
		
		@rescostpl.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["rescostpl"] = tmpf
		end
		
		@rescost.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["rescost"] = tmpf
		end
		
		@ratio1.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["ratio1"] = tmpf
		end
		
		@ratio2.change do |block|
			tmpf = block.text.to_f
			js["ability"][selectedability]["ratio2"] = tmpf
		end
		
		@ratio1type.change do |selection|
			case selection.text
			when "Ability Power" 
				js["ability"][selectedability]["ratio1type"] = "ap"
			when "Total Attack Damage"
				js["ability"][selectedability]["ratio1type"] = "ad"
			when "Max Health"
				js["ability"][selectedability]["ratio1type"] = "hp"
			when "Bonus Attack Damage"
				js["ability"][selectedability]["ratio1type"] = "bad"
			when "Armor"
				js["ability"][selectedability]["ratio1type"] = "ar"
			when "Magic Resist"
				js["ability"][selectedability]["ratio1type"] = "mr"
			when "Health Regen"
				js["ability"][selectedability]["ratio1type"] = "hr"
			when "Movespeed"
				js["ability"][selectedability]["ratio1type"] = "ms"
			when "Attack Speed"
				js["ability"][selectedability]["ratio1type"] = "as"
			when "Lifesteal"
				js["ability"][selectedability]["ratio1type"] = "ls"
			when "Spell Vamp"
				js["ability"][selectedability]["ratio1type"] = "sv"
			when "Max Mana"
				js["ability"][selectedability]["ratio1type"] = "mana"
			when "Mana Regen"
				js["ability"][selectedability]["ratio1type"] = "mreg"
			when "Armor Pen"
				js["ability"][selectedability]["ratio1type"] = "arpen"
			when "Magic Pen"
				js["ability"][selectedability]["ratio1type"] = "mrpen"
			when "% Armor Pen"
				js["ability"][selectedability]["ratio1type"] = "perarpen"
			when "% Magic Pen"
				js["ability"][selectedability]["ratio1type"] = "permrpen"
			when "Cooldown Reduction"
				js["ability"][selectedability]["ratio1type"] = "cdr"
			when "Crit Chance"
				js["ability"][selectedability]["ratio1type"] = "crit"
			when "Tenacity"
				js["ability"][selectedability]["ratio1type"] = "ten"
			else
				puts "Bruh"
			end
		end
		
		@ratio2type.change do |selection|
			case selection.text
			when "Ability Power" 
				js["ability"][selectedability]["ratio2type"] = "ap"
			when "Total Attack Damage"
				js["ability"][selectedability]["ratio2type"] = "ad"
			when "Max Health"
				js["ability"][selectedability]["ratio2type"] = "hp"
			when "Bonus Attack Damage"
				js["ability"][selectedability]["ratio2type"] = "bad"
			when "Armor"
				js["ability"][selectedability]["ratio2type"] = "ar"
			when "Magic Resist"
				js["ability"][selectedability]["ratio2type"] = "mr"
			when "Health Regen"
				js["ability"][selectedability]["ratio2type"] = "hr"
			when "Movespeed"
				js["ability"][selectedability]["ratio2type"] = "ms"
			when "Attack Speed"
				js["ability"][selectedability]["ratio2type"] = "as"
			when "Lifesteal"
				js["ability"][selectedability]["ratio2type"] = "ls"
			when "Spell Vamp"
				js["ability"][selectedability]["ratio2type"] = "sv"
			when "Max Mana"
				js["ability"][selectedability]["ratio2type"] = "mana"
			when "Mana Regen"
				js["ability"][selectedability]["ratio2type"] = "mreg"
			when "Armor Pen"
				js["ability"][selectedability]["ratio2type"] = "arpen"
			when "Magic Pen"
				js["ability"][selectedability]["ratio2type"] = "mrpen"
			when "% Armor Pen"
				js["ability"][selectedability]["ratio2type"] = "perarpen"
			when "% Magic Pen"
				js["ability"][selectedability]["ratio2type"] = "permrpen"
			when "Cooldown Reduction"
				js["ability"][selectedability]["ratio2type"] = "cdr"
			when "Crit Chance"
				js["ability"][selectedability]["ratio2type"] = "crit"
			when "Tenacity"
				js["ability"][selectedability]["ratio2type"] = "ten"
			else
				puts "Bruh"
			end
		end
		
		@abilityselect.change do |selection|
			selectedability = selection.text
			
			@bval1.text = js["ability"][selectedability]["bval1"] + js["ability"][selectedability]["bval1pl"]
			@bval1pl.text = js["ability"][selectedability]["bval1pl"]
			@bval2.text = js["ability"][selectedability]["bval2"] + js["ability"][selectedability]["bval2pl"]
			@bval2pl.text = js["ability"][selectedability]["bval2pl"]
			@rescost.text = js["ability"][selectedability]["rescost"]
			@rescostpl.text = js["ability"][selectedability]["rescostpl"]
			@basecd.text = js["ability"][selectedability]["basecd"]
			@cdpl.text = js["ability"][selectedability]["cdpl"]
			@ratio1.text = js["ability"][selectedability]["ratio1"]
			@ratio2.text = js["ability"][selectedability]["ratio2"]
			@recasts.text = js["ability"][selectedability]["recasts"]
			@recastcd.text = js["ability"][selectedability]["recastcd"]
			@recastcost.text = js["ability"][selectedability]["recastcost"]
			@recastto.text = js["ability"][selectedability]["recastto"]
			case js["ability"][selectedability]["ratio1type"]
			when "hp"
				@ratio1type.choose "Max Health"
			when "ad"
				@ratio1type.choose "Total Attack Damage"
			when "ap"
				@ratio1type.choose "Ability Power"
			when "bad"
				@ratio1type.choose "Bonus Attack Damage"
			when "ar"
				@ratio1type.choose "Armor"
			when "mr"
				@ratio1type.choose "Magic Resist"
			when "hr"
				@ratio1type.choose "Health Regen"
			when "ms"
				@ratio1type.choose "Movespeed"
			when "as"
				@ratio1type.choose "Attack Speed"
			when "ls"
				@ratio1type.choose "Lifesteal"
			when "sv"
				@ratio1type.choose "Spell Vamp"
			when "mana"
				@ratio1type.choose "Max Mana"
			when "mreg"
				@ratio1type.choose "Mana Regen"
			when "arpen"
				@ratio1type.choose "Armor Pen"
			when "mrpen"
				@ratio1type.choose "Magic Pen"
			when "perarpen"
				@ratio1type.choose "% Armor Pen"
			when "permrpen"
				@ratio1type.choose "% Magic Pen"
			when "cdr"
				@ratio1type.choose "Cooldown Reduction"
			when "crit"
				@ratio1type.choose "Crit Chance"
			when "ten"
				@ratio1type.choose "Tenacity"
			else
				puts "Bruh"
			end
			
			case js["ability"][selectedability]["ratio2type"]
			when "hp"
				@ratio2type.choose "Max Health"
			when "ad"
				@ratio2type.choose "Total Attack Damage"
			when "ap"
				@ratio2type.choose "Ability Power"
			when "bad"
				@ratio2type.choose "Bonus Attack Damage"
			when "ar"
				@ratio2type.choose "Armor"
			when "mr"
				@ratio2type.choose "Magic Resist"
			when "hr"
				@ratio2type.choose "Health Regen"
			when "ms"
				@ratio2type.choose "Movespeed"
			when "as"
				@ratio2type.choose "Attack Speed"
			when "ls"
				@ratio2type.choose "Lifesteal"
			when "sv"
				@ratio2type.choose "Spell Vamp"
			when "mana"
				@ratio2type.choose "Max Mana"
			when "mreg"
				@ratio2type.choose "Mana Regen"
			when "arpen"
				@ratio2type.choose "Armor Pen"
			when "mrpen"
				@ratio2type.choose "Magic Pen"
			when "perarpen"
				@ratio2type.choose "% Armor Pen"
			when "permrpen"
				@ratio2type.choose "% Magic Pen"
			when "cdr"
				@ratio2type.choose "Cooldown Reduction"
			when "crit"
				@ratio2type.choose "Crit Chance"
			when "ten"
				@ratio2type.choose "Tenacity"
			else
				puts "Bruh"
			end
		end
		
		
		
		@delabilityb.click do
			js = del_ability @abilityselect.text, js
			templistab = update_templist_ability js
			@abilityselect.items = templistab
			@abilityselect.choose js["ability"][0]
		end
		
		@addabilityb.click do 
			js = add_ability @newabilityl.text, emptyability, js
			templistab = update_templist_ability js
			@abilityselect.items = templistab
			@abilityselect.choose @newabilityl.text
		end
		
		@savebab.click do
			backup
			save_changes js
			@unsaved.text = " "
		end
		
		
		
		
		
	end
	
	puts "ability tab created"
	
	@tabselect.change do |selection|
		if selection.text == "Abilities" then
			@abilitytab.show
			@unittab.hide
			
			templistab = update_templist_ability js
		end
		
		if selection.text == "Units" then
			@abilitytab.hide
			@unittab.show
			
			templist = update_templist_unit js
		end
	end
	
	@tabselect.choose "Units"
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

