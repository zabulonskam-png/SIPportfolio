import processing.sound.*;
SinOsc sine1;
SawOsc saw1;
TriOsc tri1;
float freqMod;

LowPass filter;

void setup() {
  size(640, 360);
  background(255, 192, 203);
    
  // Create the sine oscillator.
  sine1 = new SinOsc(this);
  saw1 = new SawOsc(this);
  tri1 = new TriOsc(this);
  
  filter = new LowPass(this);

  sine1.play();
  saw1.play();
  tri1.play();
  
  filter.freq(200);
  filter.res(0.7);

}

void draw() {
  filter.process(sine1);
  filter.freq(map(pow(mouseX, 2), 0, pow(width, 2), 100, 8000));
  freqMod = sin(float(frameCount) / 130.) + 1;
  println(freqMod);
  sine1.freq(440 * freqMod);
  saw1.freq(100 * freqMod);
  tri1.freq(800 * freqMod);
}
