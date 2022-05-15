class Asteroid {
  PShape shape;
  float radius;
  float distance;
  float fi;
  float speed;
  PVector v;

  Asteroid(float scale, float distance, float speed, PShape shape) {
    v = PVector.random3D();
    this.shape = shape;
    shape.scale(scale);
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

    noStroke();
    translate(v.x, v.y, v.z);
    shininess(0.1);
    shape(shape);
    popMatrix();
  }

  void orbit() {
    fi += speed;
  }
}
