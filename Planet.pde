class Planet { //<>//

  float radius;
  float distance;
  float fi;
  int level;
  float speed;
  PVector v;
  PShape globe;
  boolean hasLight = false;
  boolean showLine = false;
  Planet[] children;
  Asteroid[] asteroids;

  Planet(float radius, float distance, float speed, PImage texture) {
    v = PVector.random3D();
    this.radius = radius;
    this.distance = distance;
    v.mult(distance);
    this.speed = speed;
    fi = random(TWO_PI);
    noStroke();
    noFill();
    globe = createShape(SPHERE, radius);
    globe.setTexture(texture);
  }

  void createMoons(int amount, int level) {
    children = new Planet[amount];
    for (int i = 0; i < amount; i++) {
      float r = radius / level;
      float d = random(2*(radius + r), 4*(radius + r));
      int index = (int)random(0, textures.length);
      children[i] = new Planet(r, d, random(-0.003, 0.003), textures[index]);
      if (level < 3) {
        children[i].createMoons((int)random(1, 4), level + 1);
        children[i].createMoons(3, level+1);
      }
    }
  }

  void createAsteroids(int amount, float scale) {
    asteroids = new Asteroid[amount];
    for (int i = 0; i < amount; i++) {
      float d = random(50, 60);
      asteroids[i] = new Asteroid(scale, d, random(0.005, 0.01), loadShape("data/satellite_obj.obj"));
    }
  }

  void show() {
    pushMatrix();
    fill(255);
    PVector v2 = new PVector(1, 0, 1);
    PVector p = v.cross(v2);
    rotate(fi, p.x, p.y, p.z);

    noStroke();
    translate(v.x, v.y, v.z);
    if (hasLight) {
      reflector();
    }
    //shininess(1.0);
    specular(255, 255, 0);
    shape(globe);
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].show();
      }
    }
    if (asteroids != null) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].show();
      }
    }
    popMatrix();
  }

  void orbit() {
    fi += speed;

    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].orbit();
      }
    }
    if (asteroids != null) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].orbit();
      }
    }
  }

  void setTexture(PImage texture) {
    globe.setTexture(texture);
  }

  void reflector() {
    PVector lightDir = v.copy();
    lightDir.normalize();
    PVector lightPos = PVector.mult(lightDir, -radius);
    PVector lightEndpoint = PVector.mult(lightDir, -2*radius);
    //stroke(30, 30, 0);
    //line(lightPos.x, lightPos.y, lightPos.z, lightEndpoint.x, lightEndpoint.y, lightEndpoint.z);
    lightSpecular(0, 204, 255);
    lightFalloff(1.0, 0.01, 0.0);    
    spotLight(0, 204, 255, lightPos.x, lightPos.y, lightPos.z, lightEndpoint.x, lightEndpoint.y, lightEndpoint.z, PI, 2);
  }
}
