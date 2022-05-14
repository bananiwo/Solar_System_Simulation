class Planet {

  float radius;
  float distance;
  float fi;
  int level;
  float speed;
  PVector v;
  PShape globe;
  Planet[] children;

  Planet(float radius, float distance, float speed, PImage img) {
    v = PVector.random3D();
    this.radius = radius;
    this.distance = distance;
    v.mult(distance);
    this.speed = speed;
    fi = random(TWO_PI);
    noStroke();
    noFill();
    globe = createShape(SPHERE, radius);
    globe.setTexture(img);
  }

  void createMoons(int amount, int level) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      float r = radius / level;
      float d = random(2*(radius + r), 4*(radius + r));
      int index = (int)random(0, textures.length);
      children[i] = new Planet(r, d, random(-0.03, 0.03), textures[index]);
      if (level < 3) {
        children[i].createMoons((int)random(1, 4), level + 1);
        children[i].createMoons(3, level+1);
      }
    }
  }

  void createAsteroids(int amount, float radius) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      float d = random(100, 200);
      int index = (int)random(0, textures.length);
      children[i] = new Planet(radius, d, random(-0.03, 0.03), textures[index]);
    }
  }

    void show() {
      pushMatrix();
      fill(255);
      PVector v2 = new PVector(1, 0, 1);
      PVector p = v.cross(v2);
      rotate(fi, p.x, p.y, p.z);
      //line(0, 0, 0, v.x, v.y, v.x);
      //line(0, 0, 0, p.x, p.y, p.x);
      noStroke();
      translate(v.x, v.y, v.z);
      shininess(0.1);
      //specular(255, 0, 255);
      shape(globe);
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
