extends MeshInstance3D

@export var renderDistance := 20
@export var subdivisions := 1
@export var chunkScale := 1.0
@export var playerObject : MeshInstance3D

var previousPlayerLocation := Vector2.ZERO
var chunkMeshList := []

var mutex = Mutex.new()
var job_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	
	#for x in range(-renderDistance, renderDistance):
		#var temp_row = []
		#for z in range(-renderDistance, renderDistance):
			#var temp_chunk = generateChunk(x, z)
			#temp_chunk.position = Vector3(x * (2**subdivisions * chunkScale - chunkScale), 0, z * (2**subdivisions * chunkScale - chunkScale))
			#temp_row.append(temp_chunk)
			#add_child(temp_chunk)
		#chunkMeshList.append(temp_row)
	#
func generateChunk(coordinateX, coordinateZ):
	var chunk_verticies := PackedVector3Array()
	var chunk_indices := PackedInt32Array()
	var chunk_normals := PackedVector3Array()
	var chunk_uvs := PackedVector2Array()
	
	for xCoord in range(2**subdivisions):
		for zCoord in range(2**subdivisions):
			
			var pos_x = (xCoord * chunkScale + coordinateX * (2**subdivisions * chunkScale - chunkScale)) / 10
			var pos_y = (zCoord * chunkScale + coordinateZ * (2**subdivisions * chunkScale - chunkScale)) / 10
			var verticalTranslationX = 9 * sin(pos_x / 9) ** 2 + 8 * sin(pos_x / 8) ** 4 + 7 * sin(pos_x / 7) ** 8 + 6 * sin(pos_x / 6) ** 16 + 5 * sin(pos_x / 5) ** 32 + 4 * sin(pos_x / 4) ** 64
			var verticalTranslationY = 9 * sin(pos_y / 9) ** 2 + 8 * sin(pos_y / 8) ** 4 + 7 * sin(pos_y / 7) ** 8 + 6 * sin(pos_y / 6) ** 16 + 5 * sin(pos_y / 5) ** 32 + 4 * sin(pos_y / 4) ** 64
			
			chunk_verticies.push_back(Vector3(xCoord * chunkScale, verticalTranslationX * verticalTranslationY / 100, zCoord * chunkScale))
			chunk_normals.push_back(Vector3.UP)
			chunk_uvs.push_back(Vector2(float(xCoord) * chunkScale / 2**subdivisions, float(zCoord) * chunkScale / 2**subdivisions))
			
			if xCoord != 0 and zCoord != 0:
				chunk_indices.push_back(xCoord * 2**subdivisions + zCoord)
				chunk_indices.push_back((xCoord - 1) * 2**subdivisions + zCoord)
				chunk_indices.push_back(xCoord * 2**subdivisions + zCoord - 1)
				
				chunk_indices.push_back(xCoord * 2**subdivisions + zCoord - 1)
				chunk_indices.push_back((xCoord - 1) * 2**subdivisions + zCoord)
				chunk_indices.push_back((xCoord - 1) * 2**subdivisions + zCoord - 1)
				
				# xCoord * 2**subdivision + zCoord
	
	var chunk_triangles = []
	chunk_triangles.resize(Mesh.ARRAY_MAX)
	chunk_triangles[Mesh.ARRAY_VERTEX] = chunk_verticies
	chunk_triangles[Mesh.ARRAY_NORMAL] = chunk_normals
	chunk_triangles[Mesh.ARRAY_TEX_UV] = chunk_uvs
	chunk_triangles[Mesh.ARRAY_INDEX] = chunk_indices
	
	var chunkMesh = ArrayMesh.new()
	chunkMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, chunk_triangles)
	
	
	var chunkInstance = MeshInstance3D.new()
	chunkInstance.mesh = chunkMesh
	chunkInstance.create_trimesh_collision()
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(randf(), randf(), randf())
	
	chunkMesh.surface_set_material(0, material)
	
	
	return chunkInstance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	#
	#var playerXCoord = int(playerObject.global_position.x / (2**subdivisions * chunkScale - chunkScale))
	#var playerZCoord = int(playerObject.global_position.z / (2**subdivisions * chunkScale - chunkScale))
	#
	#if playerXCoord > previousPlayerLocation.x:
		#print("x ", playerXCoord)
		#for child_mesh in chunkMeshList[0]:
			#remove_child(child_mesh)
		#chunkMeshList.pop_front()
		#
		#var tempChunkArray = []
		#for chunkZCoord in range(-renderDistance, renderDistance):
			#var newChunk = generateChunk(playerXCoord + renderDistance - 1, playerZCoord + chunkZCoord)
			#newChunk.position = Vector3((playerXCoord + renderDistance - 1) * (2**subdivisions * chunkScale - chunkScale), 0, (playerZCoord + chunkZCoord)  * (2**subdivisions * chunkScale - chunkScale))
			#tempChunkArray.append(newChunk)
			#add_child(newChunk)
		#chunkMeshList.append(tempChunkArray)
	#
	#elif playerXCoord < previousPlayerLocation.x:
		#print("x ", playerXCoord)
		#for child_mesh in chunkMeshList[-1]:
			#remove_child(child_mesh)
		#chunkMeshList.pop_back()
		#
		#var tempChunkArray = []
		#for chunkZCoord in range(-renderDistance, renderDistance):
			#var newChunk = generateChunk(playerXCoord - renderDistance, playerZCoord + chunkZCoord)
			#newChunk.position = Vector3((playerXCoord - renderDistance) * (2**subdivisions * chunkScale - chunkScale), 0, (playerZCoord + chunkZCoord)  * (2**subdivisions * chunkScale - chunkScale))
			#tempChunkArray.append(newChunk)
			#add_child(newChunk)
		#chunkMeshList.insert(0, tempChunkArray)
	#
	#if playerZCoord > previousPlayerLocation.y:
		#print("z ", playerZCoord)
		#for child_mesh_array in chunkMeshList:
			#remove_child(child_mesh_array[0])
			#child_mesh_array.pop_front()
		#
		#for chunkXCoord in range(-renderDistance, renderDistance):
			#var newChunk = generateChunk(playerXCoord + chunkXCoord, playerZCoord + renderDistance - 1)
			#newChunk.position = Vector3((playerXCoord + chunkXCoord) * (2**subdivisions * chunkScale - chunkScale), 0, (playerZCoord + renderDistance - 1)  * (2**subdivisions * chunkScale - chunkScale))
			#add_child(newChunk)
			#chunkMeshList[renderDistance + chunkXCoord].append(newChunk)
	#
	#elif playerZCoord < previousPlayerLocation.y:
		#print("z ", playerZCoord)
		#for child_mesh_array in chunkMeshList:
			#remove_child(child_mesh_array[-1])
			#child_mesh_array.pop_back()
		#
		#for chunkXCoord in range(-renderDistance, renderDistance):
			#var newChunk = generateChunk(playerXCoord + chunkXCoord, playerZCoord - renderDistance)
			#newChunk.position = Vector3((playerXCoord + chunkXCoord) * (2**subdivisions * chunkScale - chunkScale), 0, (playerZCoord - renderDistance)  * (2**subdivisions * chunkScale - chunkScale))
			#add_child(newChunk)
			#chunkMeshList[renderDistance + chunkXCoord].insert(0, newChunk)
	#
	#previousPlayerLocation = Vector2(playerXCoord, playerZCoord)
	#
