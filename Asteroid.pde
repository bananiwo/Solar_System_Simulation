class Asteroid {
  PShape shape;
  float radius;
  float distance;
  float fi;
  float speed;
  PVector v;

  Asteroid(float distance, float speed, PShape shape) {
    v = PVector.random3D();
    this.shape = shape;
    this.distance = distance;
    v.mult(distance);
    this.speed = speed;
    fi = random(TWO_PI);
    noStroke();
  }

  void show() {
    pushMatrix();
    PVector v2 = new PVector(1, 0, 1);
    PVector p = v.cross(v2);
    rotate(fi, p.x, p.y, p.z);
    shininess(0);
    specular(0);
    noStroke();
    translate(v.x, v.y, v.z);
    shape(shape);
    popMatrix();
  }

  void orbit() {
    fi += speed;
  }
}
