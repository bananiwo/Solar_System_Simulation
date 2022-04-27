class Planet {

  float radius;
  float distance;
  float fi;
  Planet[] children;

  Planet(float radius, float distance) {
    this.radius = radius;
    this.distance = distance;
    fi = random(TWO_PI);
  }

  void createMoons(int amount) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      float d = random(70, 150);
      float r = 20;
      children[i] = new Planet(r, d);
    }
  }

  void show() {
    pushMatrix();
    fill(255, 90);
    rotate(fi);
    translate(distance, 0);
    ellipse(0, 0, radius*2, radius*2);
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].show();
      }
    }
    popMatrix();
  }

  void orbit() {
    
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].orbit();
      }
    }
  }
}
