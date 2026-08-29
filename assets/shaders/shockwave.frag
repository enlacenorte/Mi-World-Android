#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform vec2 uCenter;
uniform float uProgress; // 0.0 a 1.0
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution.xy;
    vec2 centerNorm = uCenter / uResolution.xy;
    
    vec2 dir = uv - centerNorm;
    float dist = length(dir);
    
    // Anillo de distorsión refractiva que se expande
    float waveRadius = uProgress * 0.8;
    float waveWidth = 0.08;
    float diff = abs(dist - waveRadius);
    
    if (diff < waveWidth) {
        float factor = (1.0 - diff / waveWidth) * (1.0 - uProgress) * 0.035;
        vec2 offset = normalize(dir) * factor;
        fragColor = texture(uTexture, uv - offset);
        // Tinte rojo neón en la cresta de la explosión
        fragColor.r += factor * 8.0;
    } else {
        fragColor = texture(uTexture, uv);
    }
}
