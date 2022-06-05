import peasy.*;

class MyCamera {
  PVector pos; // position of camera
  float speed = 0.0f;
  PVector up;
  PVector forward;
  PVector right;
  float yawAngle = 0.0f;
  PShape ship;


  MyCamera(PVector pos, PVector lookPos, PShape ship) {
    this.pos = pos;
    this.ship = ship;
    forward = lookPos.sub(pos).normalize();
    up = new PVector(1, 1, -forward.x/forward.z); // perpendicular to forward
    float x = forward.y * up.z - forward.z * up.y;
    float y = forward.x * up.z - forward.z * up.x;
    float z = forward.x * up.y - forward.y * up.x; 
    right = new PVector(x, y, z);
  }

  void update() {
    println(yawAngle);
    //roll(yawAngle);
    pos.add(PVector.mult(forward, speed)); //<>//
   
    camera(pos.x, pos.y, pos.z, forward.x, forward.y, forward.z, up.x, up.y, up.z);
    pushMatrix();
    float distanceFromCamera = 0;
    translate(forward.x * distanceFromCamera, forward.y * distanceFromCamera, forward.z * distanceFromCamera);
    //scale(1);
    shape(ship);

    popMatrix();
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
