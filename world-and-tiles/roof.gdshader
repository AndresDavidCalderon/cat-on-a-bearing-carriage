shader_type canvas_item;

uniform float difference;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.r+COLOR.g+COLOR.b<2.5){
		COLOR.r+=difference;
		COLOR.g+=difference;
		COLOR.b+=difference;
	}
}