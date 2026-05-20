void setup() {
  size(400, 300);
}

void draw() {
  
  loadPixels();
  
  float cx = width/2;
  float cy = height/2;
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      float d = dist(x, y, cx, cy);
      float n = map(d, 0, 200, 0, 1); 
  
      // Create the color
      color c = lerpColor(color(57, 229, 123), color(208,119,195), n);

      // Set the pixel
      pixels[x + y * width] = c;
    }
  }
  updatePixels();
}
