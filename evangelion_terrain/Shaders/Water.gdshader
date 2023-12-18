shader_type spatial;

uniform vec3 albedo : source_color;
uniform vec3 fresnal_albedo : source_color;

uniform float metallic : hint_range(0.0,1.0) = 0.0;
uniform float roughness : hint_range(0.0,1.0) = 0.02;
uniform sampler2D vertex_wave;
uniform sampler2D texture_normal1;
uniform sampler2D texture_normal2;
uniform vec2 wave_vel = vec2(2.04,0.0);
uniform vec2 wave_vel2 = vec2(0.0,1.02);
uniform float time_scale : hint_range(0.0,0.2,0.005) = 0.025;
uniform float noise_scale :hint_range(0.0, 20.0, 0.1) = 20.0;
uniform float noise_height :hint_range(0.0, 5.0, 0.1) = 0.15;

varying float height;
varying vec3 world_pos;
float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow(
		(1.0 - clamp
			(dot(
				normalize(normal), normalize(view)), 0.0,1.0)), amount);
}

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	height = texture(vertex_wave, world_pos.xz / noise_scale + TIME * time_scale).r;
	VERTEX.y += height * noise_height;
}

void fragment() {
	vec2 wave_dir_time = TIME * wave_vel * time_scale;
	vec2 wave_dir_time2 = TIME * wave_vel2 * time_scale;
	
 	vec3 normal_blend = mix(texture(texture_normal2,world_pos.xz + wave_dir_time).rgb,texture(texture_normal1, world_pos.xz + wave_dir_time2).rgb,0.5);
	float fresnel = fresnel(5.0, NORMAL, VIEW);
	vec3 surface_color = mix(albedo, fresnal_albedo, fresnel);
	
	ALBEDO = surface_color;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	NORMAL_MAP = normal_blend;
}

