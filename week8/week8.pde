import processing.sound.*;
SoundFile kick;
SoundFile hat;
SoundFile drum;
SoundFile kick3;

void setup() {
  pixelDensity(1);
  size(600, 200);
  kick = new SoundFile(this, "Freesound-4.wav");
  hat = new SoundFile(this, "Freesound - Search-2.wav");
  drum = new SoundFile(this, "Freesound - Search-3.wav");
  kick3 = new SoundFile(this, "Freesound-3.wav");
  frameRate(60);
}

void draw() {
  background(0);
  int step = (frameCount / 15) % 16;
  if (frameCount % 15 == 0) {
    if (step == 0 || step == 6 || step == 8 || step == 13) kick.play();
    if (step == 4 || step == 12) drum.play();
    if (step == 3 || step == 11) kick3.play();
    hat.play();
  }
}