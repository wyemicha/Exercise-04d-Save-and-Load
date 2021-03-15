extends Node

const SAVE_PATH = "user://savegame.sav"
const SECRET = "C220 Is the Best!"
var save_file = ConfigFile.new()

onready var HUD = get_node_or_null("/root/Game/UI/HUD")
onready var Coins = get_node_or_null("/root/Game/Coins")
onready var Mines = get_node_or_null("/root/Game/Mines")
onready var Game = load("res://Game.tscn")
onready var Coin = load("res://Coin/Coin.tscn")
onready var Mine = load("res://Mine/Mine.tscn")

var save_data = {
	"general": {
		"score":0
		,"health":100
		,"coins":[]
		,"mines":[]	
	}
}


func _ready():
	update_score(0)
	update_health(0)

func update_score(s):
	save_data["general"]["score"] += s
	HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])

func update_health(h):
	save_data["general"]["health"] += h
	HUD.find_node("Health").text = "Health: " + str(save_data["general"]["health"])

func restart_level():
	HUD = get_node_or_null("/root/Game/UI/HUD")
	Coins = get_node_or_null("/root/Game/Coins")
	Mines = get_node_or_null("/root/Game/Mines")
	
	for c in Coins.get_children():
		c.queue_free()
	for m in Mines.get_children():
		m.queue_free()
	for c in save_data["general"]["coins"]:
		var coin = Coin.instance()
		coin.position = str2var(c)
		Coins.add_child(coin)
	for m in save_data["general"]["mines"]:
		var mine = Mine.instance()
		mine.position = str2var(m)
		Mines.add_child(mine)
	update_score(0)
	update_health(0)
	get_tree().paused = false

# ----------------------------------------------------------
	
func save_game():
	pass
	
func load_game():
	pass
