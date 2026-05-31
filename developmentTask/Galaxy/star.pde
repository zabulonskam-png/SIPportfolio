class Star {

 PVector loc, vel, acc;
 //PVector wind = new PVector(0.1, 0.02);  // declare globally
 //int windTimer = 0; 

 Star() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-0.05,0.05), random(-0.05,0.05));
    acc = new PVector(0, 0);
 }
void applyForce(PVector f) {
    acc.add(f);
}

 void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0); //resets each frame

    if (loc.x < 0) loc.x = width;
    if (loc.x > width) loc.x = 0;
    if (loc.y < 0) loc.y = height;
    if (loc.y > height) loc.y = 0;

 }


 void draw(){
  noStroke();
  fill(255, 240, 180);
  ellipse(loc.x, loc.y, 8, 8);
 }
}