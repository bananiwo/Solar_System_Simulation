class SpaceShip { //<>//
  PVector pos; // position of camera
  float speed = 0.0f;
  PVector up;
  PVector forward;
  PVector right;
  float rollAngle = 0.0f;
  float yawAngle = 0.0f;
  float pitchAngle = 0.0f;
  PShape ship;
  float timer = 0;


  SpaceShip(PVector pos, PVector lookPos, PShape ship) {
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

  PVector[] update() {
    timer += 0.1;
    pos.add(PVector.mult(forward, speed));
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    roll(rollAngle);
    yaw(yawAngle);
    pitch(pitchAngle);
    yawAngle = 0;
    pitchAngle = 0;

    drawAxies();

    PVector[] cameraPos = new PVector[3];
    cameraPos[0] = new PVector(pos.x, pos.y, pos.z);
    cameraPos[1] = new PVector(forward.x-pos.x, forward.y-pos.y, forward.z-pos.z);
    //cameraPos[1] = new PVector(forward.x, forward.y, forward.z);
    //cameraPos[2] = new PVector(up.x-pos.x, up.y-pos.y, up.z-pos.z);
    cameraPos[2] = new PVector(up.x, up.y, up.z);

    //shape(ship);
    popMatrix();
    return cameraPos;
  }

  void drawAxies() {
    // up - red, forward - green, right - blue
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
}
