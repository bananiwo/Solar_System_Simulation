import peasy.*; //<>//

Planet sun;
Planet myPlanet;
PImage[] textures = new PImage[4];
PImage tex_earth;
PImage textureSun;
PShape satellite;
PShape spaceshipModel;
//Camera cam;
SpaceShip ship;

float timer = 0.0;

void setup() {
  size(1200, 800, P3D);
  //camera(100, 100, 100, 0, 0, 0, 1, 0, 0);
  spaceshipModel = loadShape("data/boat/obj/boat.obj");
  ship = new SpaceShip(new PVector(10, 10, 10), new PVector(0, 0, 0), spaceshipModel);
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
  PVector[] cameraPos= ship.update();
  camera(cameraPos[0].x, cameraPos[0].y, cameraPos[0].z,
         cameraPos[1].x, cameraPos[1].y, cameraPos[1].z,
         cameraPos[2].x, cameraPos[2].y, cameraPos[2].z);
  //println(cameraPos[0]);
  //println(cameraPos[1]);
  //println(cameraPos[2]);
  
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

void mouseMoved() {
  float speedAdjustment = 1;
  ship.pitchAngle = (mouseY - pmouseY) * speedAdjustment;
  ship.yawAngle = (mouseX - pmouseX) * speedAdjustment;
  //print("\nX = ", (mouseX - pmouseX) * speedAdjustment, "  Y = ", (mouseY - pmouseY) * speedAdjustment);
}

void keyPressed() {
  if (key != CODED && keyCode == 'W' || key == CODED && keyCode == UP)
    ship.speed = 5.5f;
  if (key != CODED && keyCode == 'S' || key == CODED && keyCode == DOWN)
    ship.speed = -5.5f;
  if (key != CODED && keyCode == 'A' || key == CODED && keyCode == LEFT)
    ship.rollAngle = 0.5;
  if (key != CODED && keyCode == 'D' || key == CODED && keyCode == RIGHT)
    ship.rollAngle = -0.5f;

  if (key != CODED && keyCode == 'N')
    ship.yawAngle = 0.5f;
  if (key != CODED && keyCode == 'M')
    ship.pitchAngle = 0.5f;
}

void keyReleased() {
  if (key != CODED && keyCode == 'W' || key == CODED && keyCode == UP
    || key != CODED && keyCode == 'S' || key == CODED && keyCode == DOWN) {
    ship.speed = 0.0f;
  } else if (key != CODED && keyCode == 'A' || key == CODED && keyCode == LEFT
    || key != CODED && keyCode == 'D' || key == CODED && keyCode == RIGHT) {
    ship.rollAngle = 0.0f;
    //} else if (key != CODED && keyCode == 'N') {
    //  cam.yawAngle = 0;
    //}
    //} else if (key != CODED && keyCode == 'M') {
    //  cam.pitchAngle = 0;
  }
}
