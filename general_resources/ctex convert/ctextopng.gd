extends Node
"""
ok so basically our project didn't export properly because
for some reason when micheal uploaded his textures to github
only the cache files (.ctex files) of the textures uploaded 
so this ai generated script was made just to convert the files
back to png from ctex

so like you can ignore this as its not really part of a proejct
i just needed it as a helper tool
"""
func _ready():
	# Replace with the actual path to your .ctex file
	print("this script ran!!")
	var ctex_path = "res://general_resources/ctex convert/ctexfilesinput/plane_icon.png-af07eba15464c40c9ea3a833bc1c5f92.ctex"
	
	var texture : Texture2D = ResourceLoader.load(ctex_path)
	if texture:
		var image : Image = texture.get_image()
		# Save it to your project folder
		var err = image.save_png("res://general_resources/ctex convert/ctexfilesoutput/plane_icon.png")
		if err == OK:
			print("Successfully saved as PNG!")
		else:
			print("Failed to save PNG.")
	else:
		print("Failed to load .ctex file.")
