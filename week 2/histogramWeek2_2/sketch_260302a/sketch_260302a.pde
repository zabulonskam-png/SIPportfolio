PImage sample;

void setup() {
  size(1200, 900);
  pixelDensity(1);
  sample = loadImage("IMG_0092.JPG");
}

void draw() {
  loadPixels();

  int[] histogram = new int[256];
  
  // calculate a gray pixel from the red channel
  // and draw it to screen
  for (int i = 0; i < sample.pixels.length; i++) {
    
    
    // shade is an int from 0-255
    int pixelShade = int(red(sample.pixels[i]));
    pixels[i] = color(pixelShade);
    
    // add to histogram
    histogram[pixelShade]++;
  }  

  updatePixels();
  
  // draw histogram
  for (int i = 0; i < histogram.length; i++) {
    stroke(255, 0, 0);
    float startHeight = map(histogram[i], 0, max(histogram), height, height-(height/3));
    line(i, startHeight, i, height);
  }
}
