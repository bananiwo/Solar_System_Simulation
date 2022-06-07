class MyCamera {
  PVector pos; // position of camera
  float speed = 0.0f;
  PVector up;
  PVector forward;
  PVector right;
  float rollAngle = 0.0f;
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
    float rightX = 1;
    float rightY = 1;
    right = new PVector(rightX, rightY, (-forward.x*rightX - forward.y*rightY)/forward.z).normalize(); // perpendicular to forward
    float upX = forward.y * right.z - forward.z * right.y;
    float upY = forward.x * right.z - forward.z * right.x;
    float upZ = forward.x * right.y - forward.y * right.x;
    up = new PVector(upX, -upY, upZ).normalize();    
    //camera(pos.x, pos.y, pos.z, forward.x, forward.y, forward.z, up.x, up.y, up.z);
  }

  void update() {
    pos.add(PVector.mult(forward, speed));
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    
    // roll
     roll(rollAngle);
    
    
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
    
    float lineLen = 150;
    stroke(0, 255, 0);
    line(0, 0, 0, forward.x * lineLen, forward.y * lineLen, forward.z * lineLen);
    stroke(255, 0, 0);
    line(0, 0, 0, up.x * lineLen, up.y * lineLen, up.z * lineLen);
    stroke(0, 0, 255);
    line(0, 0, 0, right.x * lineLen, right.y * lineLen, right.z * lineLen);
    noStroke();
  }

  void pitch(float theta) {
    Quaternion q = new Quaternion(radians(theta), right);
    up = q.mult(up);
    forward = q.mult(forward);
  }

  void yaw(float theta) {
    Quaternion q = new Quaternion(radians(theta), up);
    forward = q.mult(forward);
    right = q.mult(right);
  }

  void roll(float theta) {
    Quaternion q = new Quaternion(radians(theta), forward);
    up = q.mult(up);
    right = q.mult(right);
  }

  //PVector rotate(PVector v, PVector r, float a) {
  //  Quaternion Q1 = new Quaternion(0, v.x, v.y, v.z); //<>//
  //  Quaternion Q2 = new Quaternion(cos(a / 2), r.x * sin(a / 2), r.y * sin(a / 2), r.z * sin(a / 2));
  //  Quaternion Q3 = Q2.mult(Q1).mult(Q2.conjugate());
  //  return new PVector(Q3.X, Q3.Y, Q3.Z);
  //}
}
