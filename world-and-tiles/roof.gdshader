shader_type canvas_item;

uniform float difference;
uniform float overall_liftup;
uniform bool raining;
uniform float rain_difference;

void vertex() {
	// Called for every vertex the material is visible on.
}
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
// All components are in the range [0…1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
float slerp_to(float from, float to, float weight){
	return from+(to-from)*weight;
}

void fragment() {
	if (COLOR.r+COLOR.g+COLOR.b<2.5){
		float circumstancial_difference=difference;
		if (raining){
			circumstancial_difference=rain_difference;
		}
		float median=(COLOR.r+COLOR.g+COLOR.b)/3.0;
		COLOR.r=slerp_to(COLOR.r,median,circumstancial_difference);
		COLOR.g=slerp_to(COLOR.g,median,circumstancial_difference);
		COLOR.b=slerp_to(COLOR.b,median,circumstancial_difference);
		COLOR.r+=overall_liftup;
		COLOR.g+=overall_liftup;
		COLOR.b+=overall_liftup;

	}
}// All components are in the range [0…1], including hue.
