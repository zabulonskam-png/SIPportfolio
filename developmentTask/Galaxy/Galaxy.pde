//PVector loc;
//PVector vel;
//PVector acc;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Planet> planet = new ArrayList<Planet>();
ArrayList<ExpParticle> expParts = new ArrayList<ExpParticle>(); 

PVector wind = new PVector(0.1, 0.02);  
 int windTimer = 0; 

void setup() {
  size(800, 800);
  
  for (int i = 0; i < 60; i++) {
    stars.add(new Star());
  }
  for (int i = 0; i < 10; i++) {
    planet.add(new Planet());
  }
}

void draw(){
  background(4, 6, 20);
  for (Star s : stars) {
  s.applyForce(PVector.mult(wind, 0.002)); 
  s.update(); 
  s.draw();
}
for (Planet pl : planet) {           
    pl.applyForce(PVector.mult(wind, 0.005));
    pl.update();
    pl.draw();
  }
windTimer++;
if (windTimer > 240) {  // every 240 frames
  wind.set(random(-0.3, 0.4), random(-0.1, 0.1));
  windTimer = 0;
}

for (int i = expParts.size() - 1; i >= 0; i--) {
  ExpParticle ep = expParts.get(i);
  ep.update();
  ep.draw();
  if (ep.isDead()) expParts.remove(i);  // remove dead particles
}

}
void mousePressed() {
  for (int i = planet.size() - 1; i >= 0; i--) {
    Planet pl = planet.get(i);
    float d = dist(mouseX, mouseY, pl.loc.x, pl.loc.y);
    if (d < pl.r) {
      for (int j = 0; j < 150; j++) {
        expParts.add(new ExpParticle(pl.loc.x, pl.loc.y));
      }
      planet.remove(i);  // planet disappears
    }
  }
}
  
