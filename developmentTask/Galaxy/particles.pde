class ExpParticle {

PVector loc, vel, acc;
float life;
float r;
//color col;


ExpParticle(float x, float y) {
    loc = new PVector(x, y);
    float angle = random(TWO_PI);
    float speed = random(1.5, 6.0);
    vel = new PVector(cos(angle) * speed, sin(angle) * speed);
    acc = new PVector(0, 0);

    life = 255;
    r = random(2,8);
    //col  = color(random(180,255), random(60,170), random(0,80));

}

void update() {
    vel.add(acc);
    vel.mult(0.97);   // slow down over time
    loc.add(vel);
    acc.mult(0);
    life -= 4;        // fade out 
  }
  boolean isDead() {
    return life <= 0;
  }

  void draw() {
    noStroke();
    fill(random(150, 255), random(80, 200), random(180, 240), random(80,220));
    ellipse(loc.x, loc.y, r, r);
  }
}