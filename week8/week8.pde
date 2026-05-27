import processing.sound.*;
SoundFile kick;
SoundFile hat;
SoundFile drum;
SoundFile kick3;
SoundFile sound;


void setup() {
  pixelDensity(1);
  size(400, 400);
  kick = new SoundFile(this, "Freesound-4.wav");
  //hat = new SoundFile(this, "Freesound - Search-2.wav");
  drum = new SoundFile(this, "Freesound - Search-3.wav");
  kick3 = new SoundFile(this, "Freesound-3.wav");
  sound = new SoundFile(this, "Freesound.wav");
  frameRate(60);
}

void draw() {
  background(random(255), random(255), random(255));

  int step = (frameCount / 15) % 16;
  if (frameCount % 15 == 0) {
    if (frameCount / 240 % 2 == 0) {
     if (step == 0 || step == 6 || step == 8 || step == 13) kick.play(); 
    } else { 
    if (step == 0 || step == 6 || step == 8 || step == 12) kick.play();
  }
    if (step == 4 || step == 12) drum.play();
    if (step == 3 || step == 11) kick3.play();
    if (random(1) > 0.5) sound.play();
    hat.play();
  }
}
