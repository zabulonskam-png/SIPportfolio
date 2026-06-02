class Apple {
  PImage[] idleFrames;
  PImage[] walkFrames;
  PImage[] jumpFrames;
  PImage[] fallFrames;

  float x, y;
  float vx, vy;
  float W = 64, H = 64;

  boolean onGround;
  boolean movingLeft, movingRight;
  boolean facingRight = true;
  int jumpsUsed = 0;

  Apple(float xpos, float ypos) {
    x = xpos;
    y = ypos;

    idleFrames = loadFrames("idle", 2);
    walkFrames = loadFrames("walk", 4);
    jumpFrames = loadFrames("jump", 1);
    fallFrames = loadFrames("fall", 1);
  }

  PImage[] loadFrames(String name, int count) {
    PImage[] frames = new PImage[count];
    for (int i = 0; i < count; i++) {
      String path = sketchPath("frames/" + name + "_" + i + ".png");
      frames[i] = loadImage(path);
      if (frames[i] == null) println("MISSING: " + path);
      else println("OK: " + path);
    }
    return frames;
  }

  void update(float dt) {
    vy += GRAVITY * dt;
    if (movingRight) { vx += RUN_FORCE; facingRight = true; }
    if (movingLeft)  { vx -= RUN_FORCE; facingRight = false; }
    vx *= pow(0.75, dt * 60);
    x += vx * dt;
    y += vy * dt;
    //onGround = false;
    //if (y >= GROUND) {
    //  y = GROUND;
    //  vy = 0;
    //  onGround = true;
    //  jumpsUsed = 0;
    //}
  }

  void jump() {
    if (jumpsUsed < 2) {
      vy = JUMP_VEL;
      onGround = false;
      jumpsUsed++;
    }
  }

  void draw() {
    PImage[] frames;
    if (!onGround && vy < 0)            frames = jumpFrames;
    else if (!onGround)                 frames = fallFrames;
    else if (movingLeft || movingRight) frames = walkFrames;
    else                                frames = idleFrames;

    int f = (frameCount / 8) % frames.length;
    if (frames[f] == null) return;

    PImage sprite = facingRight ? frames[f] : flipH(frames[f]);

    imageMode(CORNER);
    image(sprite, x - W/2, y - H, W, H);
  }

  PImage flipH(PImage src) {
    src.loadPixels();
    PImage dst = createImage(src.width, src.height, ARGB);
    dst.loadPixels();
    for (int row = 0; row < src.height; row++) {
      for (int col = 0; col < src.width; col++) {
        dst.pixels[row * src.width + col] = src.pixels[row * src.width + (src.width - 1 - col)];
      }
    }
    dst.updatePixels();
    return dst;
  }
}
