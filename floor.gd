extends Node3D

@export var terrainGridSizeZ := 5
@export var terrainGridSizeX := 5
@export var terrainScale := 1

@export var chunkCoordinateX := 0
@export var chunkCoordinateZ := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()
	updateChunkCoordinate()
	
	pass # Replace with function body.
func generateChunk():
	var vertices = PackedVector3Array()
	var normals = PackedVector3Array()
	var uvs = PackedVector2Array()
	var indices = PackedInt32Array()

	var chunkSubdivisions = 1
	var row_stride = chunkSubdivisions + 1

	# Create vertices
	for z in range(chunkSubdivisions + 1):
		for x in range(chunkSubdivisions + 1):
			vertices.append(Vector3(x, 0, z))
			normals.append(Vector3.UP)
			uvs.append(Vector2(
				float(x) / chunkSubdivisions,
				float(z) / chunkSubdivisions
			))

	# Create indices
	for z in range(chunkSubdivisions):
		for x in range(chunkSubdivisions):
			var i = z * row_stride + x

			# Triangle 1
			indices.append(i)
			indices.append(i + row_stride)
			indices.append(i + 1)

			# Triangle 2
			indices.append(i + 1)
			indices.append(i + row_stride)
			indices.append(i + row_stride + 1)

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	self.mesh = mesh


func generateChunk1():
	var chunkVerticies = PackedVector3Array()
	var chunkNormals = PackedVector3Array()
	var chunkUV = PackedVector2Array()
	var chunkIndices = PackedInt32Array()
	
	var chunkSubdivisions = 1
	
	var previousRow = 0
	var thisRow = 0
	
	for x in range(chunkSubdivisions + 1):
		for z in range(chunkSubdivisions + 1):
			
			chunkVerticies.append(Vector3(x, 0, z))
			# chunkNormals.append(Vector3(x, 0, z).normalized())
			chunkNormals.append(Vector3.UP)
			chunkUV.append(Vector2(float(x) / chunkSubdivisions, float(z) / chunkSubdivisions))
			
	
			
			if x > 0 and z > 0:
				chunkIndices.append(previousRow + z - 1)
				chunkIndices.append(previousRow + z)
				chunkIndices.append(thisRow + z - 1)
				
				chunkIndices.append(previousRow + z)
				chunkIndices.append(thisRow + z)
				chunkIndices.append(thisRow + z - 1)
				
				print("juno")
			
		previousRow = thisRow
		thisRow += 1
	
	print(chunkVerticies)
	print(chunkIndices)
	print(chunkNormals)
	print(chunkUV)
	
	
	
	var chunkTriangles = []
	chunkTriangles.resize(ArrayMesh.ARRAY_MAX)
	chunkTriangles[Mesh.ARRAY_VERTEX] = chunkVerticies
	chunkTriangles[Mesh.ARRAY_NORMAL] = chunkNormals
	chunkTriangles[Mesh.ARRAY_TEX_UV] = chunkUV
	chunkTriangles[Mesh.ARRAY_INDEX] = chunkIndices
	
	var chunkMesh = ArrayMesh.new()
	chunkMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, chunkTriangles)
	
	self.mesh = chunkMesh
	


func generate_terrain():
	var terrainVertecies = PackedVector3Array()
	var terrainNormals = PackedVector3Array()
	var terrainUV = PackedVector2Array()
	var terrainIndices = PackedInt32Array()
	
	# Create verticies
	for z in range(terrainGridSizeZ + 1):
		for x in range(terrainGridSizeX + 1):
			var vx = x * terrainScale - terrainGridSizeX * terrainScale * 0.5
			var vz = z * terrainScale - terrainGridSizeZ * terrainScale * 0.5
			terrainVertecies.append(Vector3(vx, 0.0, vz))
			terrainNormals.append(Vector3.UP)
			terrainUV.append(Vector2(float(vx) / terrainGridSizeX, float(vz) / terrainGridSizeZ))
	
	for z in range(terrainGridSizeZ):
		for x in range(terrainGridSizeX):
			var indice = z * (terrainGridSizeX) + x
			
			terrainIndices.append(indice)
			terrainIndices.append(indice + terrainGridSizeX + 1)
			terrainIndices.append(indice + 1)
			
			terrainIndices.append(indice + 1)
			terrainIndices.append(indice + terrainGridSizeX + 1)
			terrainIndices.append(indice + terrainGridSizeX + 2)
	
	# Build da mesh
	var terrainTrianglesArray = []
	terrainTrianglesArray.resize(Mesh.ARRAY_MAX)
	terrainTrianglesArray[Mesh.ARRAY_VERTEX] = terrainVertecies
	terrainTrianglesArray[Mesh.ARRAY_NORMAL] = terrainNormals
	terrainTrianglesArray[Mesh.ARRAY_TEX_UV] = terrainUV
	terrainTrianglesArray[Mesh.ARRAY_INDEX] = terrainIndices
	
	print(terrainIndices)
	
	var terrainMesh = ArrayMesh.new()
	terrainMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, terrainTrianglesArray)
	
	self.mesh = terrainMesh

	for v in terrainVertecies:
		var c = MeshInstance3D.new()
		var mesh1 = BoxMesh.new()
		mesh1.size = Vector3(0.1, 0.1, 0.1)
		c.mesh = mesh1
		# c.size = Vector3(1, 1, 1)
		c.global_position = v + self.global_position
		add_child(c)


func updateChunkCoordinate():
	var world_x = chunkCoordinateX * terrainGridSizeX * terrainScale
	var world_z = chunkCoordinateZ * terrainGridSizeZ * terrainScale
	
	print(world_z)
	
	global_position = Vector3(world_x, 0.0, world_z)
	
	print(global_position)
	
	var cube1 = MeshInstance3D.new()
	
	var box_mesh = BoxMesh.new()
	box_mesh.size = Vector3(1, 1, 1)
	
	cube1.mesh = box_mesh
	cube1.position = Vector3(0, 1, 0)
	
	add_child(cube1)	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
