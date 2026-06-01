class Apple {

 float x, y; 
 float vx, vy; 
 //float speed;


 boolean onGround;
 boolean movingLeft;
 boolean movingRigh;
 int     jumpsUsed   = 0; 

Apple(float xpos, float ypos){
    x = xpos;
    y = ypos;
    vx = 0; 
    vy = 0;
    onGround = false;

}

void update(float dt) {
   vy += GRAVITY * dt; //gravity 

   if (movingRight) vx += RUN_FORCE;
   if (movingLeft)  vx -= RUN_FORCE;
   vx *= pow(0.75, dt * 60); 

    x += vx * dt;
    y += vy * dt;

     if (y >= GROUND) {
      y = GROUND;
      vy = 0;
      onGround = true;
    }
}
  }

  void jump(){
    if (jumpsUsed < 2) {          
    vy = JUMP_VEL;         
    onGround = false;
    jumpsUsed++;

  }
}

void resolveX() { //to stop apple from going through walls
    float halfW = W / 2;

    f (vy < 0) { // moving up — check top edge
      if (solidAt(x - W/2 + 2, y - halfH) ||
          solidAt(x + W/2 - 2, y - halfH)) {
        y  = floor((y - halfH) / getTileSize()) * getTileSize() + getTileSize() + halfH;
        vy = 0;
      }
    }

     if (vy > 0) { // moving down — check bottom edge
      if (solidAt(x - W/2 + 2, y + halfH) ||
          solidAt(x + W/2 - 2, y + halfH)) {
        y        = floor((y + halfH) / getTileSize()) * getTileSize() - halfH;
        vy       = 0;
        onGround = true;
        jumpsUsed = 0; // reset double-jump on landing
      } else {
        onGround = false;
      }
    }
  }

void draw() {
  }

  