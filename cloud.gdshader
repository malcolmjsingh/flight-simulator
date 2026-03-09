shader_type spatial;

render_mode blend_mix, depth_prepass_alpha, cull_disabled;

void fragment() {
    ALBEDO = vec3(1.0);
    ALPHA = 0.6;
}

void vertex() {
    mat4 modified_model_view = VIEW_MATRIX * mat4(
        INV_VIEW_MATRIX[0],
        INV_VIEW_MATRIX[1],
        INV_VIEW_MATRIX[2],
        MODEL_MATRIX[3]
    );
    MODELVIEW_MATRIX = modified_model_view;
}