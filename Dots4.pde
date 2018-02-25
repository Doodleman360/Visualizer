class Dots4 implements Frame {
  float radius = 20;
  float d1, d2, d3, d4;
  int size = in.bufferSize();
  float init = 50;

  public void frame() {
    colorMode(RGB);
    d1 = init;
    d2 = init;
    d3 = init;
    d4 = init;
    fill(0, 0, 0, 32);
    noStroke();
    rect(0, 0, width, height);

    for (int i = 0; i < size; i++) {
      if (i < size/4) d1 += fix(in.mix.get(i));
      else if (i < size/2) d2 += fix(in.mix.get(i));
      else if (i < size*3/4) d3 += fix(in.mix.get(i));
      else  d4 += fix(in.mix.get(i));
    }
    d1 = d1/size * (width + height);
    d2 = d2/size * (width + height);
    d3 = d3/size * (width + height);
    d4 = d4/size * (width + height);

    fill(255, 255, 255, 64);
    ellipse(width/4, height/4, d1, d1);
    ellipse(width*3/4, height/4, d2, d2);
    ellipse(width/4, height*3/4, d3, d3);
    ellipse(width*3/4, height*3/4, d4, d4);
  }
  float fix(float in) {
    return in;
  }
}