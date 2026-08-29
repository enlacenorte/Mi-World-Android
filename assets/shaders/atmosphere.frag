#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform vec4 uAtmosphereColor;
uniform float uPulseTime;

out vec4 fragColor;

void main() {
    vec2 st = (FlutterFragCoord().xy - 0.5 * uResolution.xy) / min(uResolution.x, uResolution.y);
    float dist = length(st);
    
    // Esfera base con radio 0.42
    float radius = 0.42;
    float edge = smoothstep(radius - 0.02, radius + 0.08, dist);
    float glow = exp(-dist * 4.5) * (1.0 + 0.15 * sin(uPulseTime * 2.5));
    
    if (dist < radius) {
        // Fresnel interior
        float rim = 1.0 - sqrt(1.0 - (dist / radius) * (dist / radius));
        fragColor = mix(vec4(0.04, 0.08, 0.22, 1.0), uAtmosphereColor, pow(rim, 2.5));
    } else {
        // Halo exterior de neón
        fragColor = uAtmosphereColor * glow * (1.0 - edge);
    }
}
