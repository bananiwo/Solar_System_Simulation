import peasy.*;

Planet sun;
PImage texture;

PeasyCam cam;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 500);
  texture = loadImage("jp3.png");
  emissive(200, 200, 0);
  sun = new Planet(40, 0, 0);
  emissive(0, 0, 0);
  sun.createMoons(4, 2);
  noStroke();
}

void draw() {
  background(0);
  ambientLight(5, 5, 0);
  pointLight(200, 200, 0, 0, 0, 0);
  //lightFalloff(1.0, 0.0, 0.0);
  //spotLight(51, 102, 126, 200, 200, 1600, 0, 0, -1, PI/16, 600);
  sun.show();
  sun.orbit();
}
