Planet sun;
Planet sun2;

void setup() {
  size(1000, 1000);
  sun = new Planet(20, 0, 0);
  sun.createMoons(5, 2);
  noStroke();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  sun.show();
  sun.orbit();
}
