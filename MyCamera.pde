 //<>//
class MyCamera {
  PVector pos; // position of camera
  float speed = 0.0f;
  PVector up;
  PVector forward;
  PVector right;
  float yawAngle = 0.0f;
  PShape ship;
  float timer = 0;

  MyCamera(PVector pos, PVector lookPos, PShape ship) {
    this.pos = pos;
    this.ship = ship;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(30);
    popMatrix();
    
    // produce 3 perpendicular unit vectors, with 'forward' being from pos to lookPos
    forward = lookPos.sub(pos).normalize();
    float upX = 1;
    float upY = 1;
    up = new PVector(upX, upY, (-forward.x*upX - forward.y*upY)/forward.z).normalize(); // perpendicular to forward
    float rightX = forward.y * up.z - forward.z * up.y;
    float rightY = forward.x * up.z - forward.z * up.x;
    float rightZ = forward.x * up.y - forward.y * up.x;
    right = new PVector(rightX, -rightY, rightZ).normalize();
    
    print("\nforward and up", forward.dot(up));
    print("\nup and right", up.dot(right));
    print("\nright and forward", right.dot(forward));
    
    //camera(pos.x, pos.y, pos.z, forward.x, forward.y, forward.z, up.x, up.y, up.z);
  }

  void update() {
    pos.add(PVector.mult(forward, speed));
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //PVector offsetH = PVector.mult(forward, -200);
    PVector offsetV = PVector.mult(up, 800);
    //PVector offset = PVector.add(offsetH, offsetV);
    //camera(-300, -150, 0, forward.x, forward.y, forward.z, up.x, up.y, up.z);
    //camera(offsetV.x, offsetV.y, offsetV.z, forward.x, forward.y, forward.z, up.x, up.y, up.z);
    drawAxies();
    //shape(ship);
    popMatrix();
  }

  void drawAxies() {
    stroke(255, 0, 0);
    float lineLen = 150;
    line(0, 0, 0, forward.x * lineLen, forward.y * lineLen, forward.z * lineLen);
    line(0, 0, 0, up.x * lineLen, up.y * lineLen, up.z * lineLen);
    line(0, 0, 0, right.x * lineLen, right.y * lineLen, right.z * lineLen);
    noStroke();
  }

  void pitch(float theta) {
    up = rotate(up, right, theta);
    forward = rotate(forward, right, theta);
  }

  void yaw(float theta) {
    forward = rotate(forward, up, theta);
    right = rotate(right, up, theta);
  }

  void roll(float theta) {
    right = rotate(right, forward, theta);
    up = rotate(up, forward, theta);
  }

  PVector rotate(PVector v, PVector r, float a) {
    Quaternion Q1 = new Quaternion(0, v.x, v.y, v.z);
    Quaternion Q2 = new Quaternion(cos(a / 2), r.x * sin(a / 2), r.y * sin(a / 2), r.z * sin(a / 2));
    Quaternion Q3 = Q2.mult(Q1).mult(Q2.conjugate());
    return new PVector(Q3.X, Q3.Y, Q3.Z);
  }
}
