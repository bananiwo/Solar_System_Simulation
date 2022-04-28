class Planet {

  float radius;
  float distance;
  float fi;
  int level;
  float speed;
  color planetColor;
  Planet[] children;

  Planet(float radius, float distance, float speed) {
    this.radius = radius;
    this.distance = distance;
    this.speed = speed;
    planetColor = color(random(0, 255),random(0, 255),random(0, 255));
    fi = random(TWO_PI);
  }

  void createMoons(int amount, int level) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      float d = 2 * random(400, 850) / sq(level);
      //float r = radius / level;
      float r = radius / level;
      children[i] = new Planet(r, d, random(-0.03, 0.03));
      if (level < 3) {
        children[i].createMoons((int)random(1, 4), level + 1);
      }
    }
  }

  void show() {
    pushMatrix();
    fill(planetColor);
    rotate(fi);
    translate(distance, 0);
    circle(0, 0, radius*2);
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
