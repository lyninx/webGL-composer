attribute vec3 direction;
attribute vec3 centroid;
attribute vec3 random;

uniform vec3 color;
uniform float animate;
uniform float spin;
uniform float opacity;
uniform float scale;

#define PI 3.1415

void main() {
  // rotate the triangles
  // each half rotates the opposite direction
  float swirl = 2.0;
  float theta = (1.0 - animate) * (PI * swirl) * sign(centroid.x);
  float theta2 = (1.0 - spin) * (PI * 2.0);
  
  mat3 rotMat = mat3(
    vec3(cos(theta), 0.0, sin(theta)),
    vec3(0.0, 1.0, 0.0),
    vec3(-sin(theta), 0.0, cos(theta))
  );
  mat3 rotMat2 = mat3(
    vec3(1.0, 0.0, 0.0),
    vec3(0.0, cos(-2.0 * direction.y), -sin(-2.0 * direction.y)),
    vec3(0.0, sin(-2.0 * direction.y), cos(-2.0 * direction.y))
  );
  mat3 rotMat3 = mat3(
    vec3(cos(theta2), -sin(theta2), 0.0),
    vec3(sin(theta2), cos(theta2), 0.0),
    vec3(0.0, 0.0, 1.0)
  );
  
  vec3 offset = mix(vec3(0.0), direction.xyz * rotMat, 1.0 - animate);
  vec3 spin = position.xyz * rotMat3;
  // scale triangles to their centroids
  vec3 tPos = mix(mix(centroid.xyz, spin, animate), spin * rotMat2, 1.0 - animate) + offset;
  vec3 pos = tPos;
  
  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}