//PVector loc;
//PVector vel;
//PVector acc;

ArrayList<Star> stars = new ArrayList<Star>();

void setup() {
  size(800, 800);
  
  for (int i = 0; i < 60; i++) {
    stars.add(new Star());
  }
}

void draw(){
  background(4, 6, 20);
  
  //vel.add(acc);
  //loc.add(vel);
  
  for (Star s: stars) {
    s.update();
    s.draw();
  }
}
  
