class Planet {

 PVector loc, vel, acc;
 float r;
 float ringAngle;
 //PVector wind = new PVector(0.1, 0.02);  // declare globally
 //int windTimer = 0; 

 Planet() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-0.05,0.05), random(-0.05,0.05));
    acc = new PVector(0, 0);
    r = random(22, 40);
    ringAngle = random(-0.4, 0.4); 
 }

 void applyForce(PVector f) {
    acc.add(f);
}

 void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0); //resets each frame

    if (loc.x < 0)      loc.x = width;
    if (loc.x > width)  loc.x = 0;
    if (loc.y < 0)      loc.y = height;
    if (loc.y > height) loc.y = 0;
  }
 


 void draw(){
  drawRing();  
  noStroke();
  for (int i = 0; i < 530; i++){
    float angle = random(TWO_PI);
    float dist = random(0, r);
    float px = loc.x + cos(angle) * dist;
    float py = loc.y + sin(angle) * dist;
  fill(random(150, 255), random(80, 200), random(180, 240), random(80,220));
  ellipse(px, py, random(0.9, 0.9), random(0.9, 0.9));

 }
}
void drawRing() {
    pushMatrix();
    translate(loc.x, loc.y);  // move to planet centre
    rotate(ringAngle);        

    noFill();


    // inner ring — thinner, brighter
    strokeWeight(r * 0.05);
    stroke(255, 20, 200, 100);
    ellipse(0, 0, r * 2.6, r * 0.6);

    noStroke();
    popMatrix();
  }
}