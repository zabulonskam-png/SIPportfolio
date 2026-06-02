ArrayList<Plat> platforms;
ArrayList<Spike> spikes;
Finish finish;

int deaths = 0;

class Plat {
    float x, y, w, h;
    color c;

    Plat(float x, float y, float w, float h, color c) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
    }

    void draw() {
        noStroke(); fill(c); rect(x, y, w, h);
    }

    void collideY(Apple a) {
        float aL = a.x - a.W/2, aR = a.x + a.W/2;
        float aT = a.y - a.H,   aB = a.y;
        if (aR <= x || aL >= x+w || aB <= y || aT >= y+h) return;
        if (a.vy >= 0 && aB - y < (y+h) - aT) {
            a.y = y; a.vy = 0; a.onGround = true; a.jumpsUsed = 0;
        } else if (a.vy < 0) {
            a.y = y + h + a.H; a.vy = 0;
        }
    }

    void collideX(Apple a) {
        float aL = a.x - a.W/2, aR = a.x + a.W/2;
        float aT = a.y - a.H,   aB = a.y;
        if (aR <= x || aL >= x+w || aB <= y || aT >= y+h) return;
        if (aR - x < (x+w) - aL) {
            a.x = x - a.W/2; a.vx = 0;
        } else {
            a.x = x + w + a.W/2; a.vx = 0;
        }
    }
}

class Spike {
    float x, y, w, h;

    Spike(float x, float y, float w, float h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    void draw() {
      noStroke();
      fill(255, 0, 0);
      rect(x, y, w, h);
    }

    boolean hits(Apple a) {
        return a.x + a.W/2 > x && a.x - a.W/2 < x+w &&
               a.y > y && a.y - a.H < y+h;
    }
}

class Finish {
    float x, y, r;

    Finish(float x, float y, float r) {
      this.x = x;
      this.y = y;
      this.r = r;
    }

    void draw() {
      noStroke();
      fill(250, 160, 5);
      ellipse(x, y, r, r);
    }

    boolean hits(Apple a) {
        return dist(a.x, a.y - a.H/2, x, y) < r/2 + a.W/4;
    }
}

void loadLevel() {
    platforms = new ArrayList<Plat>();
    spikes    = new ArrayList<Spike>();
    finish    = null;

    // floor
    platforms.add(new Plat(0, height-10, width, 10, color(204, 255, 204)));

    // stepping platforms (left to right)
    platforms.add(new Plat(150,  420, 200, 20, color(23, 176, 0)));  // bottom-left
    platforms.add(new Plat(430,  350, 90,  20, color(23, 176, 0)));  // mid-left
    platforms.add(new Plat(610,  280, 90,  20, color(23, 176, 0)));  // top-center
    platforms.add(new Plat(810,  350, 90,  20, color(23, 176, 0)));  // right-center
    platforms.add(new Plat(1020, 420, 110, 20, color(23, 176, 0)));  // bottom-right

    // spike zone across the middle floor
    spikes.add(new Spike(430, 460, 620, 80));

    // finish ball at the far right
    finish = new Finish(1250, 460, 45);
}

void drawLevel() {
    for (Plat  p : platforms) p.draw();
    for (Spike s : spikes)    s.draw();
    if (finish != null) finish.draw();
}

void checkCollisions(Apple a) {
    for (Plat p : platforms) p.collideY(a);
    for (Plat p : platforms) p.collideX(a);
    for (Spike s : spikes) {
        if (s.hits(a)) {
          a.x = 50; a.y = height-10; a.vx = 0; a.vy = 0;
          deaths++;
        }
    }
    if (a.y > height + 80) {
      a.x = 50; a.y = height-10; a.vx = 0; a.vy = 0;
      deaths++;
    }
    if (finish != null && finish.hits(a)) {
      gameComplete = true;
    }
}

//Reference: https://openprocessing.org/@u446705/2275388
//Developed with AI assistance for code analysis from the reference and implementation support.
//AI Model used: CLAUDE Sonnet 4.6
