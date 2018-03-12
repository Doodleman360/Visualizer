class Window extends Frame {
  float amt = in.bufferSize();
  ArrayList<Droplet> rain = new ArrayList<Droplet>();
  PImage bg;
  boolean bt = false;

  Window() {
    bg = loadImage("rain/bg.jpg");
    bg.resize(width, height);
  }
  
  void load() {
    bg.resize(width, height);
  }

  void frame() {
    colorMode(RGB);
    background(0);
    tint(255, 100);
    image(bg, 0, 0);
    noTint();
    if (beat.isOnset()) {
      fill(255, 64);
      noStroke();
      rect(0, 0, width, height);
      bt = true;
    } else if (bt) {
      fill(255, 64);
      noStroke();
      rect(0, 0, width, height);
      bt = false;
    }
    strokeWeight(4);
    for (int i = 1; i < amt; i+=4) {
      float i1 =  in.mix.get(i);
      float i2 =  in.mix.get(i - 1);
      if (random(1) < .5)
        rain.add(new Droplet(random(width), 0, i1/2 + 1/2, 128 * i2 + 128, 128 * i2 + 128, 128 * i2 + 128));
      else 
      rain.add(new Droplet(0, random(height), i1/2 + 1/2, 128 * i2 + 128, 128 * i2 + 128, 128 * i2 + 128));
    }

    for (int i = 0; i < rain.size(); i++) {
      Droplet drop = rain.get(i);
      drop.inc();
      drop.setStroke();
      line(drop.x, drop.y, drop.x(), drop.y());
      if (drop.x > width || drop.y > height) drop.remove = true;
    }
    for (int i = 0; i < rain.size(); i++) {
      if (rain.get(i).remove) rain.remove(i);
    }
  }
}

class Droplet {
  public boolean remove = false;
  public float r, g, b, a = 255;
  public float x = 0, y = 0;
  public float size = 0;
  public float speed = 0;

  Droplet(float x, float y, float size, float r, float g, float b) {
    this.x = x; 
    this.y = y;
    this.size = size; 
    this.r = r;
    this.g = g;
    this.b = b;
    this.speed = random(20) + 20;
  }
  void setStroke() {
    stroke(r, g, b, a);
    strokeWeight(size);
  }
  void inc() {
    x += speed;
    y += speed;
    a *= .99;
    if (a < 10) remove = true;
  }
  float x() {
    return x - speed;
  }
  float y() {
    return y - speed;
  }
}