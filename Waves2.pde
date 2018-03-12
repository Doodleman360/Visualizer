class Waves2 extends Frame {

  float amt = in.bufferSize()/2;
  float w, h;
  float[] mixt = new float[(int)amt];
  float[] maxt = new float[(int)amt];
  float[] mixb = new float[(int)amt];
  float[] maxb = new float[(int)amt];
  float off = 0.90;
  int last = 0;
  boolean vertical = false;
  //double counter = 0;

  void load() {
    w = width / (amt - 2);
    h = height / (amt - 2);
  }
  void frame() {
    colorMode(RGB);
    background(0);

    pushMatrix();
    if (vertical) {
      translate(width/2, 0);
    } else {
      translate(0, height/2);
    }
    for (int i = 0; i < amt; i+= 2) {
      mixt[i] *= 0.9;
      mixb[i] *= 0.9;
      if (mixt[i] < in.mix.get(i)) {
        mixt[i] = in.mix.get(i);
      }
      if (-mixb[i] > in.mix.get(i)) {
        mixb[i] = -in.mix.get(i);
      }
    }

    for (int i = 0; i < amt; i++) {
      if (mixt[i] > maxt[i]) {
        maxt[i] = mixt[i];
      } else {
        maxt[i]*=.98;
      }

      if (mixb[i] > maxb[i]) {
        maxb[i] = mixb[i];
      } else {
        maxb[i]*=.98;
      }
    }

    strokeWeight(3);
    float i1, i2, a;
    for (int i = 2; i < amt; i++) {
      stroke(225);
      if (vertical) {
        i1 = -abs(maxt[i - 2]) * (width);
        i2 = -abs(maxt[i]) * (width);
        if (i1 != 0 && i2 != 0)
          line(i1, (i - 2) * h, i2, i * h);
      } else { 
        i1 = -abs(maxt[i - 2]) * (height/2);
        i2 = -abs(maxt[i]) * (height/2);
        if (i1 != 0 && i2 != 0)
          line((i - 2) * w, i1, i * w, i2);
      }
      a = 150+100 * mixt[i];
      stroke(100, a, 100);

      if (vertical) {
        i1 = -abs(mixt[i - 2]) * (width);
        i2 = -abs(mixt[i]) * (width);      
        if (i1 != 0 && i2 != 0)
          line(i1, (i - 2) * h, i2, i * h);
      } else {
        i1 = -abs(mixt[i - 2]) * (height/2); 
        i2 = -abs(mixt[i]) * (height/2);      
        if (i1 != 0 && i2 != 0)
          line((i - 2) * w, i1, i * w, i2);
      }

      stroke(225);

      if (vertical) {
        i1 = abs(maxb[i - 2]) * (width);
        i2 = abs(maxb[i]) * (width);      
        if (i1 != 0 && i2 != 0)
          line(i1, (i - 2) * h, i2, i * h);
      } else { 
        i1 = abs(maxb[i - 2]) * (height/2);
        i2 = abs(maxb[i]) * (height/2);
        if (i1 != 0 && i2 != 0)
          line((i - 2) * w, i1, i * w, i2);
      }

      a = 150+100 * mixb[i];
      stroke(100, a, 100);
      if (vertical) {
        i1 = abs(mixb[i - 2]) * (width);
        i2 = abs(mixb[i]) * (width); 
        if (i1 != 0 && i2 != 0)
          line(i1, (i - 2) * h, i2, i * h);
      } else {
        i1 = abs(mixb[i - 2]) * (height/2); 
        i2 = abs(mixb[i]) * (height/2); 
        if (i1 != 0 && i2 != 0)
          line((i - 2) * w, i1, i * w, i2);
      }
    }
    popMatrix();
  }
  void toggle() {
    vertical = !vertical;
  }
}