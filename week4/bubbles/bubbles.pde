float t = 0;

void setup(){
  size(600, 400);
}

void draw(){
  background(125, 26, 35);
  
  for (int i = 0; i < 20; i++){
    
    float x = noise(i * 10 + t) * width;
    float y = noise(i * 20 + t) * height;
    
    float size = noise(i * 30 + t) * 50;
    
    fill(255, 200);
    noStroke();
    
    ellipse(x, y, size, size);
  }
  t += 0.01;
}
