editjson.rb commands:

addunit <name> - Adds a unit to the JSON, the name of the unit is case sensitive with the project class!

removeunit <name> - Removes a unit from the JSON, making it default to the "hardcoded" project settings.

changestat <unit> <stat> <value> - Changes a unit's default stat to the specified value. Stat reference at the bottom of this file.

printallunits - Prints all registered units

printunitstats <unit> - Prints the stats for the specified unit as rows of [{key}, {value}]

help [command] - Shows what commands are available. If a command is specified, shows the help for it.



Stat reference:

hppl - HP increase Per Pevel

bhp - Base starting HP

bad - Base starting Attack Damage

adpl - Attack Damage increase Per Level

bms - Base Movement Speed

bar - Base starting ARmor (physical/autoattack resistance)

arpl - ARmor increase Per Pevel

bas - Base Attack Speed. 100 AS means 1 attack per second, linearly increasing up to 2.5 attacks per second, or 250 AS total

aspl - Attack Speed increase Per Level

bmr - Base Magic Resist (ability resistance)

mrpl - Magic Resist increase Per Level

bhr - Base Health Regen per second

hrpl - Health Regen increase Per Level