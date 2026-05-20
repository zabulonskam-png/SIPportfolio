void setup() {
  size(400, 300);
}

void draw() {
  
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float n = map(y, 0, height - 1, 0, 1); 
  
      // Create the color
      color c = lerpColor(color(11, 19, 43), color(208,119,195), n);

      // Set the pixel
      pixels[x + y * width] = c; 
    }
  }
  updatePixels();
}
