extends Node

func _ready():
	# 1. Create a MeshInstance3D node
	var mesh_instance = MeshInstance3D.new()
	add_child(mesh_instance)
	
	# 2. Define vertices and indices
	var vertices := PackedVector3Array()
	vertices.push_back(Vector3(0, 0, 0)) # Vertex 0
	vertices.push_back(Vector3(1, 0, 0)) # Vertex 1
	vertices.push_back(Vector3(1, 0, 1)) # Vertex 2
	vertices.push_back(Vector3(0, 0, 1)) # Vertex 3
	
	# Define indices for two triangles (clockwise winding order)
	var indices := PackedInt32Array()
	# First triangle: 0, 1, 2
	indices.push_back(0)
	indices.push_back(1)
	indices.push_back(2)
	# Second triangle: 0, 2, 3
	indices.push_back(0)
	indices.push_back(2)
	indices.push_back(3)
	
	# 3. Create the main array and assign data
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	
	# You should also add normals for correct lighting
	# For simple cases, SurfaceTool can automatically generate normals:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(vertices.size()):
		st.add_vertex(vertices[i])
	for i in range(indices.size()):
		st.add_index(indices[i])
	# Generate normals (and tangents if needed)
	st.generate_normals()
	st.generate_tangents() 
	
	var array_mesh = st.commit() # Commit to a new ArrayMesh

	# If not using SurfaceTool for normals, use the manual approach:
	# var array_mesh = ArrayMesh.new()
	# array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	# Optional: Add a material
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.1, 0.5, 0.9)
	array_mesh.surface_set_material(0, material)

	# 5. Assign the mesh to the MeshInstance3D
	mesh_instance.mesh = array_mesh
