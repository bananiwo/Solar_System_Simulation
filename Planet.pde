class Planet {

  float radius;
  float distance;
  float fi;
  int level;
  float speed;
  color planetColor;
  PVector v;
  PShape globe;
  Planet[] children;

  Planet(float radius, float distance, float speed) {
    v = PVector.random3D(); 
    this.radius = radius;
    this.distance = distance;
    v.mult(distance);
    this.speed = speed;
    planetColor = color(random(0, 255), random(0, 255), random(0, 255), 80);
    fi = random(TWO_PI);
    noStroke();
    noFill();

    globe = createShape(SPHERE, radius);
    globe.setTexture(texture);
  }

  void createMoons(int amount, int level) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      //float d = 2 * random(400, 850) / sq(level);
      //float r = radius / level;
      float r = radius / level;
      float d = random(2*(radius + r), 4*(radius + r));
      children[i] = new Planet(r, d, random(-0.03, 0.03));
      if (level < 3) {
        children[i].createMoons((int)random(1, 4), level + 1);
        children[i].createMoons(3, level+1);
      }
    }
  }

  void show() {
    pushMatrix();
    //fill(planetColor);
    fill(255);
    PVector v2 = new PVector(1, 0, 1);
    PVector p = v.cross(v2);
    rotate(fi, p.x, p.y, p.z);
    stroke(255);
    strokeWeight(3);
    //line(0, 0, 0, v.x, v.y, v.x);
    //line(0, 0, 0, p.x, p.y, p.x);
    noStroke();
    translate(v.x, v.y, v.z);
    //circle(0, 0, radius*2);
    shape(globe);
    //sphere(radius);
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].show();
      }
    }
    popMatrix();
  }

  void orbit() {
    pushMatrix();
    fi += speed;
    //float b = 100; // mniejsza srednica
    //float e = 0.8; // wspolczynnik ksztaltu CHYBA
    //distance = b / sqrt(1 - sq(e*cos(fi)));
    //distance = a*(1-e*e)/(1-e*cos(fi));
    //distance = 50 * sqrt(16 / (sq(cos(fi)) + 4*sq(sin(fi)))); // sun is orbit's focal point
    popMatrix();

    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].orbit();
      }
    }
  }
}
