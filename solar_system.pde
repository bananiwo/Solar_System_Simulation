import peasy.*;

Planet sun;
Planet myPlanet;
PImage[] textures = new PImage[4];
PImage tex_earth;
PImage textureSun;
PShape satellite;
PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 500);
  textureSun = loadImage("data/texture_sun.jpg");
  textures[0] = loadImage("data/texture_planet_1.png");
  textures[1] = loadImage("data/texture_planet_2.png");
  textures[2] = loadImage("data/texture_planet_3.png");
  textures[3] = loadImage("data/texture_planet_4.jpg");
  tex_earth = loadImage("data/texture_earth.jpg");
  satellite = loadShape("data/Satellite.obj");
  satellite.scale(0.7);

  emissive(200, 200, 200);
  sun = new Planet(40, 0, 0, textureSun);
  emissive(0, 0, 0);
  sun.createMoons(3, 2);
  myPlanet = sun.children[0];
  myPlanet.setTexture(tex_earth);
  myPlanet.createAsteroids(5, satellite);
  myPlanet.hasLight = true;
  myPlanet.showLine = true;
  myPlanet.speed = 0.001;
  noStroke();
}

void draw() {
  background(0);
  lightSpecular(200, 200, 200);
  pointLight(255, 255, 255, 0, 0, 0);
  sun.show();
  sun.orbit();
  myPlanet.orbit();
}
