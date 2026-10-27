shader_type spatial;

uniform sampler2D Texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	ALBEDO = (texture(Texture, world_vertex.xy) + texture(Texture, world_vertex.xz) + texture(Texture, world_vertex.yz)).xyz * .333333333;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
