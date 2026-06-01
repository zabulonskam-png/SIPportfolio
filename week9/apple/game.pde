float GRAVITY   = 1500;  // downward pull  (px per second²)
float JUMP_VEL  = -560;  // jump strength  (negative = up)
float RUN_FORCE =  0.6;  // run acceleration per frame
float FRICTION  =  0.75; // speed decay 
float MAX_SPEED =  5.0;  // top horizontal speed (px per frame)



Apple apple;

void setup() {
    size(700, 340); 

}
void draw(){
    float dt = 1.0 / frameRate;
    background(30, 10, 60);  
    apple.update(dt);
    apple.draw();  
}

void keyPressed() {
  if (keyCode == LEFT  || key == 'a' || key == 'A') apple.movingLeft  = true;
  if (keyCode == RIGHT || key == 'd' || key == 'D') apple.movingRight = true;
  if (keyCode == UP    || key == 'w' || key == 'W') apple.jump();
  if (key == ' ') apple.jump();
}

void keyReleased() {
  if (keyCode == LEFT  || key == 'a' || key == 'A') apple.movingLeft  = false;
  if (keyCode == RIGHT || key == 'd' || key == 'D') apple.movingRight = false;
}