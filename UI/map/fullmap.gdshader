shader_type canvas_item;

uniform float right;
uniform float left;
uniform float up;
uniform float down;
uniform float fade_distance;

void vertex() {
	// Called for every vertex the material is visible on.
}

float get_alpha(float outby){
	return 1.0-outby/fade_distance;
}

void fragment() {
	COLOR=texture(TEXTURE,UV);
	if (UV.x>right){
		COLOR.a*=get_alpha(UV.x-right);
	}
	if (UV.y>down){
		COLOR.a*=get_alpha(UV.y-down);
	}
	if (UV.y<up){
		COLOR.a*=get_alpha(up-UV.y);
	}
	if (UV.x<left){
		COLOR.a*=get_alpha(left-UV.x);
	}
	
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
