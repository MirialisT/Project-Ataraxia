extends Resource
class_name DynamicNPCGen

@export var race_library: Dictionary = {
		0: {
			"race_name": "Human",
			"Male": ["Alex", "Arni", "Alfred", "Balos"],
			"Female": ["Lesly", "Shana", "Sera", "Amily"]
		},
		1: {
			"race_name": "Elf",
			"Male": ["Aleriel", "Arinal", "Alferos", "Baloriel"],
			"Female": ["Lesaliel", "Sha'na", "Serali", "Amilai"]
		}
	}
@export var sex_library: Array = ["Male", "Female"]

func generate_npc():
	var rand_race = race_library[randi() % race_library.size()]
	var rand_sex: String = sex_library[randi_range(0,1)]
	var rand_name: String
	var names_amount: int = rand_race[rand_sex].size()
	match rand_sex:
		"Male": rand_name = rand_race[rand_sex][randi() % names_amount]
		"Female": rand_name = rand_race[rand_sex][randi() % names_amount]
	return [rand_race["race_name"], rand_sex, rand_name]
