extends Node2D

var inrange = false
var canspeak = true

export var line:String

onready var base = get_node("/root/game")
onready var player = get_node("/root/game/player")
onready var accept = get_node("/root/game/dialogue/dialogue/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/accept")
onready var cancel = get_node("/root/game/dialogue/dialogue/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/cancel")
# Called when the node enters the scene tree for the first time.

func _ready():
	base.connect("dialogue_end", self, "_on_dialogue_end")
	accept.connect("pressed", self, "_on_accept")
	cancel.connect("pressed", self, "_on_deny")
	pass#base.get_node("gui/dialogue").connect("purchased", self, "_on_nextline")

func _on_accept():
	player.give_berry()
	$KinematicBody2D/text.reappear = false
	yield(player, "berry_end")

	$KinematicBody2D/AnimationPlayer.play("close")
	
	
func _on_deny():
	$KinematicBody2D/text.reappear = true

func _on_text_body_entered(body):
	if body.is_in_group("player"):
		inrange = true


func _on_text_body_exited(body):
	if body.is_in_group("player"):
		inrange = false
		

func _input(event):
	if inrange && event.is_action_pressed("interact") && base.speaking == false:
		base.dialogue_set(line)
		#print(dialoguenum)

func _on_dialogue_end():
	if inrange:
		pass

func dialogue_setget(val):
	pass
	#base.npc_dialogue[npcname] = val
	#dialoguenum = val

