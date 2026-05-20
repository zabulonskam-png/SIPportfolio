void setup() {
  size(400, 300);
}

void draw() {
  
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
    
      float n = map(x, 0, width - 1, 0, 1); 
  
      // Create the color
      color c = lerpColor(color(11, 19, 43), color(57, 229, 255), n);

      // Set the pixel
      pixels[x + y * width] = c; // Correctly index the 1D pixel array
    }
  }
  updatePixels();
}
