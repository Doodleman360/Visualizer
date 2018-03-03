class Dots extends Frame {
  float radius = 20;
  int root = (int)sqrt(in.bufferSize());
  float dx, dy;
  int size = in.bufferSize();

  void load() {
    dx = width/(int)root;
    dy = height/(int)root;
  }
  
  public void frame() {
    fill(0, 0, 0, 64);
    noStroke();
    rect(0, 0, width, height);
    fill(200);
    if (radius > 30) {
      radius*=.99;
    } else radius = 20;
    if (beat.isOnset()) radius = 100;


    float x = 0;
    float y = 1;
    for (int i = 0; i < (int)root*(int)root; i++, x++ ) {
      if (x > root) {
        x = 0;
        y++;
        if (y >= root) return;
      }
      float mix = abs(in.mix.get(i));

      ellipse(dx * x + dx/2, dy * y, radius * mix, radius * mix);
    }
  }
}