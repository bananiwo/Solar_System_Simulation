import peasy.*; //<>//

Planet sun;
Planet myPlanet;
PImage[] textures = new PImage[4];
PImage tex_earth;
PImage textureSun;
PShape satellite;
PShape spaceship;
PeasyCam pCam;
MyCamera cam;

float timer = 0.0;

void setup() {
  size(1200, 800, P3D);
  //pushMatrix();
  //translate(500, 500, 500);
  pCam = new PeasyCam(this, 10);
  //popMatrix();
  spaceship = loadShape("data/boat/obj/boat.obj");
  cam = new MyCamera(new PVector(500, 500, 500), new PVector(0, 0, 0), spaceship);
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
  drawPlane();
  cam.update();
  ambient(30);
  lights();
  lightSpecular(200, 200, 200);
  pointLight(255, 255, 255, 0, 0, 0);
  //sun.show();

  //sun.orbit();
  //myPlanet.orbit();
}

void drawPlane() {
  beginShape();
  fill(0, 0, 50);
  vertex(-500, -200, 500);
  vertex(-500, -200, -500);
  vertex( 500, -200, -500);
  vertex( 500, -200, 500);
  endShape(CLOSE);
}

void keyPressed() {
  if (key != CODED && keyCode == 'W' || key == CODED && keyCode == UP)
    cam.speed = 5.5f;
  if (key != CODED && keyCode == 'S' || key == CODED && keyCode == DOWN)
    cam.speed = -5.5f;
  if (key != CODED && keyCode == 'A' || key == CODED && keyCode == LEFT)
    cam.yawAngle = 0.5;
  if (key != CODED && keyCode == 'D' || key == CODED && keyCode == RIGHT)
    cam.yawAngle = -0.5f;
}

void keyReleased() {
  if (key != CODED && keyCode == 'W' || key == CODED && keyCode == UP
    || key != CODED && keyCode == 'S' || key == CODED && keyCode == DOWN) {
    cam.speed = 0.0f;
  } else if (key != CODED && keyCode == 'A' || key == CODED && keyCode == LEFT
    || key != CODED && keyCode == 'D' || key == CODED && keyCode == RIGHT) {
    cam.yawAngle = 0.0f;
  }
}
