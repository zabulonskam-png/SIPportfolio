import processing.video.*;

color colorA;
color colorB;

Capture cam;

boolean takePicture = false;

void setup() {
  size(640, 480);
  pixelDensity(1);
  // this code sets up `cam` as a Capture device, using the first camera
  // on your computer.
  // if this doesn't work: speak to Tom
  String[] cameras = Capture.list();
  
  colorA = color(221,60,90);
  colorB = color(6,67,169);
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, 640,480,cameras[0], 30);
    cam.start();     
  }      
}


void draw() {
  // every frame, if the camera is ready, we update `cam` to have
  // the latest data from it
  if (cam.available() == true) {
    cam.read();
  }
  
  // this next line is for TESTING
  // once the image appears on screen, delete it, and uncomment the code below
  //image(cam,0,0);
  
  // to draw the new image pixel-by-pixel:
  // the Capture object (cam) has a property "pixels" that works just like a screen.
  loadPixels();
  cam.loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    // convert pixel to greyscale
    float greyValue = red(cam.pixels[i]);

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

  // Floyd-Steinberg Dithering
  //
  // x is the current pixel:
  //
  //  .  x  7
  //  3  5  1
  //  (all /16)

  int[] offsets = {
    1, width-1, width, width+1
  };

  float[] ditherRatios = {
    7/16.0, 3/16.0, 5/16.0, 1/16.0
  };


  for (int j = 0; j < offsets.length; j++) {
    int neighbourIndex = i + offsets[j];
    if (neighbourIndex < pixels.length) {
      float neighbourGrey = red(pixels[neighbourIndex]);
      pixels[neighbourIndex] = color(neighbourGrey + (error*ditherRatios[j]));
    }
  }
}

void atkinsonDither(int i, float error) {
  
  // Atkinson Dithering
  //
  // x is the current pixel:
  //
  //  .  x  1  1
  //  1  1  1  .
  //  .  1  .  .
  //  (all / 8)


  int[] offsets = {
    1, 2, width-1, width, width+1, width*2
  };
  

  for (int j = 0; j < offsets.length; j++) {
    int neighbourIndex = i + offsets[j];
    if (neighbourIndex < pixels.length) {
      float neighbourGrey = red(pixels[neighbourIndex]);
      pixels[neighbourIndex] = color(neighbourGrey + (error/8.0));
    }
  }
  
}
