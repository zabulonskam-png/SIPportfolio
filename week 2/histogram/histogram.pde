PImage sample;

void setup() {
  size(517, 606);
  pixelDensity(1);
  sample = loadImage("sample.jpg");
}

void draw() {
  loadPixels();

  int[] histogram = new int[256];
  
  // calculate a gray pixel from the red channel
  // and draw it to screen
  for (int i = 0; i < sample.pixels.length; i++) {
    
    
    // shade is an int from 0-255
    int pixelShadeR = int(red(sample.pixels[i]));
    int pixelShadeG = int(green(sample.pixels[i]));
    int pixelShadeB = int(blue(sample.pixels[i]));
    pixels[i] = color(pixelShadeR,pixelShadeG,pixelShadeB);
    
    // add to histogram
    histogram[pixelShadeR]++;
  }  

  updatePixels();
  
  // draw histogram
  for (int i = 0; i < histogram.length; i++) {
    stroke(255, 0, 0);
    float startHeight = map(histogram[i], 0, max(histogram), height, height-(height/3));
    line(i, startHeight, i, height);
  }
}
