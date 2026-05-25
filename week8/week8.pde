import processing.sound.*;

SoundFile kick;
SoundFile kick1;
SoundFile kick2;
SoundFile kick3;

void setup() {
  pixelDensity(1);
  size(400, 400);
  kick = new SoundFile(this, "kick_w_echo_1s.wav");
  kick.play();
  kick1 = new SoundFile(this, "Freesound-1.wav");
  //kick1.play();
  kick2 = new SoundFile(this, "Freesound.wav");
  kick3 = new SoundFile(this, "Freesound-3.wav");
  //kick2.play();
  frameRate(60);

}

void draw() {
  int step = (frameCount / 15) % 16;
  background(0);
  if (step == 0 && frameCount % 30 == 0) {
  kick.play();
}
if (frameCount % 40 == 0) {
  kick1.play();
}
if (frameCount % 20 == 0) {
  kick2.play();
}
if (frameCount % 30 == 0) {
  kick3.play();
}
}
