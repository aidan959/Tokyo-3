shader_type spatial;
uniform sampler2D noise_texture;
uniform sampler2D color;

varying vec3 world_pos;
uniform float time_scale : hint_range(0.0,1.0);

uniform float roughness : hint_range(0.0,1.0);
void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz * roughness + vec2(TIME * time_scale)).r;
	VERTEX+= NORMAL * height;
}
float fresnel(vec3 normal, mat4 camera_matrix) {
	vec3 view_direction_world = (camera_matrix * vec4(0.0,0.0,1.0,0.0)).xyz;
	vec3 normal_world = (camera_matrix * vec4(normal, 0.0)).xyz;
	float fresnel  = dot (view_direction_world, normal_world);
	fresnel =clamp(abs(fresnel),0.0,1.0);
	return 1.0 - fresnel;
}
void fragment() {
	float fresnel = fresnel(NORMAL, VIEW_MATRIX);
	ALBEDO = texture(color, world_pos.xz + vec2(TIME * 0.41)).rgb;
	ROUGHNESS=0.0f;
	ALPHA = fresnel;
	// Place fragment code here.
}
