class Waves extends Frame {
  float amt = in.bufferSize();
  float w;
  float[] mixt = new float[(int)amt];
  float[] maxt = new float[(int)amt];
  float[] mixb = new float[(int)amt];
  float[] maxb = new float[(int)amt];
  float off = 0.90;
  //double counter = 0;

  void load() {
    w = width / amt;
  }
  
  void frame() {
    colorMode(RGB);
    noStroke();
    fill(0);
    background(200);

    pushMatrix();
    translate(0, height/2);



    for (int i = 0; i < amt; i++) {
      mixt[i] *= 0.9;
      mixb[i] *= 0.9;
      if (mixt[i] < in.mix.get(i)) {
        mixt[i] = in.mix.get(i);
      }
      if (-mixb[i] > in.mix.get(i)) {
        mixb[i] = -in.mix.get(i);
      }
    }

    //counter += 0.001;
    //off = Math.abs((float)Math.sin(counter))*.2 + .8;
    //if (off > 1) off = 1;
    //text("%"+String.valueOf(100 - off * 100).substring(0, 2), 50, 20 - height/2);

    for (int i = 0; i < amt; i++) {
      fix(i);
      fix2(i);
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

    for (int i = 0; i < amt; i++) {
      fill(225);
      rect(i*w, 0, w, -abs(maxt[i])*(height/2));

      float a = 50+150 * mixt[i];
      fill(50 - mixt[i]*50, a, a);
      rect(i*w, 0, w, -abs(mixt[i])*(height/2));

      fill(225);
      rect(i*w, 0, w, abs(maxb[i])*(height/2));

      float b = 50+150 * mixb[i];
      fill(50 - mixb[i]*50, a, a);
      rect(i*w, 0, w, abs(mixb[i])*(height/2));
    }
    popMatrix();
  }

  void fix(int i) {
    if (i <= 0) {
      if (mixt[0] < mixt[1] * off) {
        mixt[0] = mixt[1] * off;
        fix(1);
      }
    } else if (i >= amt - 1) {
      if (mixt[(int)amt - 1] < mixt[(int)amt - 2] * off) {
        mixt[(int)amt - 1] = mixt[(int)amt - 2] * off;
        fix((int)amt - 2);
      }
    } else {
      if (mixt[i] < mixt[i-1] * off) {
        mixt[i] = mixt[i-1] * off;
        fix(i+1);
      }
      if (mixt[i] < mixt[i+1] * off) {
        mixt[i] = mixt[i+1] * off;
        fix(i-1);
      }
    }
  }
  void fix2(int i) {
    if (i <= 0) {
      if (mixb[0] < mixb[1] * off) {
        mixb[0] = mixb[1] * off;
        fix(1);
      }
    } else if (i >= amt - 1) {
      if (mixb[(int)amt - 1] < mixb[(int)amt - 2] * off) {
        mixb[(int)amt - 1] = mixb[(int)amt - 2] * off;
        fix((int)amt - 2);
      }
    } else {
      if (mixb[i] < mixb[i-1] * off) {
        mixb[i] = mixb[i-1] * off;
        fix(i+1);
      }
      if (mixb[i] < mixb[i+1] * off) {
        mixb[i] = mixb[i+1] * off;
        fix(i-1);
      }
    }
  }
}