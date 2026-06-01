import processing.video.*;

color colorA;
color colorB;

Capture cam;

boolean takePicture = false;


void setup() {
  size(640, 480);
  pixelDensity(1);
  
  String[] cameras = Capture.list();
  
  colorA = color(101,30,40);
  colorB = color(16,67,69);
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    
    cam = new Capture(this, 640,480,cameras[0], 30);
    cam.start();     
  }      
}


void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  // Guard against empty frames
  if (cam.width == 0 || cam.pixels == null) return;


  cam.loadPixels();
  image(cam, 0, 0);
  loadPixels(); 
  
  for (int i = 0; i < cam.pixels.length; i++) {
    // convert pixel to greyscale
    float greyValue = (red(cam.pixels[i]) + green(cam.pixels[i]) + blue(cam.pixels[i])) / 3.0;

    // threshold pixel to either black or white.
    float newPixelValue = 0;

    if (greyValue > 127) {
      newPixelValue = 255;
    }

    float error = greyValue - newPixelValue;

    pixels[i] = color(newPixelValue);

    // diffuse error onwards
    //diffuseError(i,error);
    //atkinsonDither(i,error);
    fsDither(i, error);

  }
  for(int i = 0; i < pixels.length; i++) {
    pixels[i] = threshold(pixels[i],100);
    pixels[i] = duotone(pixels[i], colorA, colorB);
    pixels[i] = contrast(pixels[i], 222);
  }
  updatePixels();

if (takePicture) {
  saveFrame("frame-####.jpg");
    println("Picture saved!");
    takePicture = false;
  }
}

void keyPressed() {
  if (key == 's') {
    takePicture = true;
  }
}

color threshold(color pixel, int threshold) {
   if (red(pixel) > threshold) {
     return color(255);
   } else {
     return color(0);
   }
}  

color duotone(color pixel, color colorA, color colorB) {
  float tone = red(pixel);
  
  float lerpAmount = norm(tone,0,255);
  
  return lerpColor(colorA, colorB, lerpAmount);
}

color sepia(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);
  
  float outputRed = (r * .393) + (g *.769) + (b * .189);
  float outputGreen = (r * .349) + (g *.686) + (b * .168);
  float outputBlue = (r * .272) + (g *.534) + (b * .131);
  
  return color(outputRed, outputGreen, outputBlue);
}

color contrast(color pixel, float contrastAmount) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  float contrastFactor = (259*(contrastAmount+255)) / (255* (259-contrastAmount));

  r = (contrastFactor * (r -128)) + 128;
  g = (contrastFactor * (g -128)) + 128;
  b = (contrastFactor * (b -128)) + 128;

  return color(r, g, b);
}

color brighten(color pixel, float brightness) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = r + brightness;
  g = g + brightness;
  b = b + brightness;

  return color(r, g, b);
}

color invert(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);

  r = 255-r;
  g = 255-g;
  b = 255-b;

  return color(r, g, b);
}

void fsDither(int i, float error) {
  int x = i % width;

  int[] offsets      = {1,        width-1,  width,    width+1};
  float[] ratios     = {7/16.0,   3/16.0,   5/16.0,   1/16.0};
  boolean[] edgeGuard = {x < width-1,  x > 0,  true,  x < width-1};

  for (int j = 0; j < offsets.length; j++) {
    int ni = i + offsets[j];
    if (edgeGuard[j] && ni < pixels.length) {
      float g = red(pixels[ni]);
      pixels[ni] = color(g + error * ratios[j]);
    }
  }
}

void atkinsonDither(int i, float error) {
  int x = i % width;

  int[] offsets       = {1,        2,        width-1,  width,  width+1,  width*2};
  boolean[] edgeGuard = {x < width-1, x < width-2, x > 0, true, x < width-1, true};

  for (int j = 0; j < offsets.length; j++) {
    int ni = i + offsets[j];
    if (edgeGuard[j] && ni < pixels.length) {
      float g = red(pixels[ni]);
      pixels[ni] = color(g + error / 8.0);
    }
  }
}