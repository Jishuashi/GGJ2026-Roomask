extends TileMapLayer

@export var width : int = 10
@export var heigh : int = 10

func	_ready() -> void:
	generate_rhombus()
	
func generate_rhombus() -> void:
	clear()
	
	for x in range(width):
		for y in range(heigh):
			set_cell(Vector2i(x, y), 1, Vector2i(0, 0))
