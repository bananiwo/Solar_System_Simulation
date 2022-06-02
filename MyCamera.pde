class MyCamera {
  PVector pos;
  PVector lookPos;
  float moveSpeed = 1.0f;
  boolean ifMoveForward = false;
  float upX = 0.0f;
  float upY = 0.0f;
  float upZ = 1.0f;
  
  MyCamera(PVector pos, PVector lookPos) {
    this.pos = pos;
    this.lookPos = lookPos;
  }

  void update() {
     
  }
  
  void moveForward() {
    PVector lookDir = lookPos.sub(pos).normalize();
    pos.add(lookDir.mult(moveSpeed));
  }
  
    void moveBackward() {
    PVector lookDir = lookPos.sub(pos).normalize();
    pos.add(lookDir.mult(-moveSpeed));
  }
  
  void yawRight() {
      
  }
  
  void look() {
   camera(pos.x, pos.y, pos.y, lookPos.x, lookPos.y, lookPos.z, upX, upY, upZ); 
  }
  
}
