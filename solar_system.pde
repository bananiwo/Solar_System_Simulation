Planet sun;

void setup() {
  size(800, 600);
  sun = new Planet(60, 10);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  sun.createMoons(4);
  sun.show();
  //sun.orbit();
}
