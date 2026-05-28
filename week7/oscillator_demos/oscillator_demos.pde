
import processing.sound.*;

// oscillators

SawOsc saw;
TriOsc tri;
SinOsc sin;

Oscillator[] oscillators; // individual oscillators subclass Oscillator, so we can do this
String[] oscnames;
int currentOsc = 0;



// filter
LowPass lpFilter;


// analysis stuff
Waveform waveform;
int waveformSamples = 512;

FFT fft;
int fftBands = 512;
float[] spectrum = new float[fftBands];


// global sound object for handling volume
Sound s;

void setup() {
  size(600, 600);

  // overall volume of Sound library
  s = new Sound(this);
  s.volume(0.13);

  // setup  a bunch of oscillators
  saw = new SawOsc(this);
  tri = new TriOsc(this);
  sin = new SinOsc(this);

  lpFilter = new LowPass(this);

  oscillators = new Oscillator[] { saw, tri, sin};
  oscnames = new String[] { "Saw", "Triangle", "Sine" };

  // Waveform analysis
  waveform = new Waveform(this, waveformSamples);

  // FFT analysis
  fft = new FFT(this, fftBands);

  // finally, make the first oscillator our current one
  selectOsc(0);
}

void draw() {
  background(255, 192, 203);
fill(0);

updateSound();
    

 text(oscnames[currentOsc], width/2, 15);
  
}

void selectOsc(int o) {
  // stop the old oscillator
  if (currentOsc > 0) {
    oscillators[currentOsc].stop();
  } 

  // select the new oscillator
  currentOsc = o;

 
  waveform.input(oscillators[currentOsc]);
  fft.input(oscillators[currentOsc]);

  // play the new oscillator
  oscillators[currentOsc].play();
  println(oscnames[currentOsc]);
}

void keyPressed() {
  switch(key) {
  case ' ' :
     selectOsc((currentOsc + 1) % oscillators.length);
  }
}

void updateSound() {
  oscillators[currentOsc].amp(map(mouseY, height, 0, 0, 1));
  oscillators[currentOsc].freq(map(pow(mouseX, 2), 0, pow(width, 2), 80, 2000));

}
