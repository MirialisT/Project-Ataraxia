extends Resource
class_name DynamicNPCGen
# TODO: EXPAND
@export var race_library: Dictionary = {
		0: {
			"race_name": "Human",
			"Male": ["Alex", "Arni", "Alfred", "Balos"],
			"Female": ["Lesly", "Shana", "Sera", "Amily"]
		},
		1: {
			"race_name": "HalfElf",
			"Male": ["Aler", "Arin", "Alfer", "Balor"],
			"Female": ["Lesali", "Sha'na", "Sera", "Amilai"]
		},
		2: {
			"race_name": "Elf",
			"Male": ["Aleriel", "Arinal", "Alferos", "Baloriel"],
			"Female": ["Lesaliel", "Sha'na", "Serali", "Amilai"]
		},
		3: {
			"race_name": "HighElf",
			"Male": ["Aleriel", "Arinal", "Alferos", "Baloriel"],
			"Female": ["Lesaliel", "Sha'nari", "Seralis", "Amilais"]
		},
		4: {
			"race_name": "BeastMan",
			"Male": ["Asat", "Ashar", "Ali", "Bast"],
			"Female": ["Lira", "Shiha", "Shani", "Akata"]
		}
	}
@export var sex_library: Array = ["Male", "Female"]

func generate_npc():
	var rand_race = race_library[randi() % race_library.size()]
	var rand_sex: String = sex_library[randi_range(0,1)]
	var rand_name: String
	var names_amount: int = rand_race[rand_sex].size()
	rand_name = rand_race[rand_sex][randi() % names_amount]
	return [rand_race["race_name"], rand_sex, rand_name]
	
func generate_npc_monorace(_race_id: int):
	#0xF = 0b1111 = first 4 races -> yes
	pass
