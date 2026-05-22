float t = 0;

void setup() {
  size(600, 400);
}

void draw() {
  background(200, 20, 70);

  stroke(190, 250, 255);
  noFill();

  for (int i = 0; i < width; i++) {

    float x = noise(i * 0.01, t) * height;
    line(i, x, i, height);
  }

  t += 0.01;
}
