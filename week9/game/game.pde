float GRAVITY   = 1500;  // downward pull  (px per second²)
float JUMP_VEL  = -560;  // jump strength  (negative = up)
float RUN_FORCE =  50.6;  // run acceleration per frame
float FRICTION  =  10; // speed decay 
float MAX_SPEED =  15.0;  // top horizontal speed (px per frame)
float GROUND    =  540;  // floor y position

boolean gameComplete = false;



Apple apple;

void setup() {
    size(1300, 550);
    loadLevel();
    apple = new Apple(50, GROUND);

}
void draw(){
    float dt = 1.0 / frameRate;
    background(30, 10, 60);  
    apple.onGround = false;
    apple.update(dt);
    drawLevel();
    checkCollisions(apple);
    apple.draw();
    
    fill(255);
    textSize(18);
    textAlign(LEFT, TOP);
    text("Deaths: " + deaths, 10, 10);
    
    if (gameComplete){
      background(0);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(60);
      text("YOU HAVE ESCAPED!", width/2, height/2 -50);
      textSize(25);
      text("Deaths: " + deaths, width/2, height/2 + 20);
      text("Press R to play again", width/2, height/2 + 60);
      return;
    }
}

void keyPressed() {
  if (keyCode == LEFT  || key == 'a' || key == 'A') apple.movingLeft  = true;
  if (keyCode == RIGHT || key == 'd' || key == 'D') apple.movingRight = true;
  if (keyCode == UP    || key == 'w' || key == 'W') apple.jump();
  if (key == ' ') apple.jump();
  if (key == 'r' || key == 'R'){
    gameComplete = false;
    deaths = 0;
    loadLevel();
    apple = new Apple(50, GROUND);
  }
}

void keyReleased() {
  if (keyCode == LEFT  || key == 'a' || key == 'A') apple.movingLeft  = false;
  if (keyCode == RIGHT || key == 'd' || key == 'D') apple.movingRight = false;
}

//reference: https://youtu.be/l8pzu9n2TvU?si=TOQCIZvFF8kFRseL
