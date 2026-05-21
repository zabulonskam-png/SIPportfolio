void setup() {
  size(600, 600);
  background(20);
  noStroke();
}

void draw() {

  for (int x = 1; x < width; x += 60) {
    for (int y = 1; y < height; y += 60) {

      int pattern = (x + y) % 180;

      if (pattern % 3 == 0) {
        fill(255, 80, 120);
        ellipse(x + 30, y + 30, 40, 40);   // primitive 1
      } 
      else if (pattern % 3 == 1) {
        fill(80, 200, 255);
        rect(x + 10, y + 10, 40, 40);      // primitive 2
      } 
      else {
        fill(255, 220, 100);
        triangle(x + 30, y + 10, x + 10, y + 50, x + 50, y + 50); // primitive 3
      }
      stroke(255, 50);
      line(x, y, x + 60, y + 60);  // primitive 4
      noStroke();
    }
  }

  noLoop(); 
}
