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
      float n = map(d, 0, 200, 0, 1); // Normalize x to 0-1
  
      // Create the color
      color c;
      if(n < 0.5){
        c = lerpColor(color(107, 29, 123), color(208,107,255), n*2);
      } else {
        c = lerpColor(color(11, 229, 223), color(255,19,195), (n - 0.5)*2 );
      }
      // Set the pixel
      pixels[x + y * width] = c; // Correctly index the 1D pixel array
    }
  }
  updatePixels();
}
