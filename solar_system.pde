import peasy.*;

Planet sun;
Planet myPlanet;
PImage[] textures = new PImage[5];
PImage textureSun;
PeasyCam cam;

void setup() {
  size(1600, 980, P3D);
  cam = new PeasyCam(this, 500);
  textureSun = loadImage("data/texture_sun.jpg");
  textures[0] = loadImage("data/texture_planet_1.png");
  textures[1] = loadImage("data/texture_planet_2.png");
  textures[2] = loadImage("data/texture_planet_3.png");
  textures[3] = loadImage("data/texture_planet_4.jpg");
  textures[4] = loadImage("data/texture_planet_5.jpg");
  
  emissive(200, 200, 200);
  sun = new Planet(40, 0, 0, textureSun);
  emissive(0, 0, 0);
  sun.createMoons(2, 2);
  myPlanet = sun.children[0];
  myPlanet.createMoons(4, 2);
  noStroke();
}

void draw() {
  background(0);
  ambientLight(195, 195, 195);
  pointLight(200, 200, 200, 0, 0, 0);
  sun.show();
  //sun.orbit();
  myPlanet.orbit();
}
