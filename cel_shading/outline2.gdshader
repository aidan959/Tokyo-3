shader_type spatial;

render_mode cull_front, unshaded, depth_draw_never;

global uniform vec4 outline_color;
global uniform float outline_width;
varying float distance_to_camera;
const float distance_threshold=7.0f; 
void vertex() {
	vec4 world_vertex_pos = VIEW_MATRIX * vec4(VERTEX, 1.0);
    distance_to_camera = length(INV_VIEW_MATRIX[3].xyz - world_vertex_pos.xyz);
	vec4 clip_position = 
			PROJECTION_MATRIX *
			(MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
	vec3 clip_normal =
			mat3(PROJECTION_MATRIX) *
			(mat3(MODELVIEW_MATRIX) * NORMAL);
	clip_position.xy +=
			normalize(clip_normal.xy) /
			VIEWPORT_SIZE *
			clip_position.w *
			3.0;
	if (distance_to_camera < distance_threshold){
		
		POSITION = clip_position;
	}
}

void fragment() {
	
	if (distance_to_camera < distance_threshold){
		ALBEDO = outline_color.rgb;
	} else {
		ALPHA = 0.0f;
	}
}
