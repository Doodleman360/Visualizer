class Wave extends Frame {
  float amt = in.bufferSize();
  float w;
  float[] wave = new float[(int)amt];
  ArrayList<Integer> max;
  ArrayList<Integer> min;
  
  void load() {
    w = width / amt;
  }
  
  void frame() {
    colorMode(RGB);
    noStroke();
    background(0);

    pushMatrix();
    translate(0, height/2);

    for (int i = 0; i < amt; i++) {
      /*wave[i] *= 0.9;
       if (in.mix.get(i) > 0) {
       if (wave[i] < in.mix.get(i)) {
       wave[i] = in.mix.get(i);
       }
       } else {
       if (wave[i] > in.mix.get(i)) {
       wave[i] = in.mix.get(i);
       }
       }*/
      wave[i] = in.mix.get(i);
    }
    max = new ArrayList<Integer>();
    min = new ArrayList<Integer>();
    for (int i = 1; i < amt - 1; i++) {
      if (wave[i - 1] < wave[i] && wave[i] > wave[i + 1]) {
        max.add(i);
      } else if (wave[i - 1] > wave[i] && wave[i] < wave[i + 1]) {
        min.add(i);
      }
      
    }

    //for (int i = 0; i < amt; i++) {
    //  fix(i);
    //}

    strokeWeight(2);
    for (int i = 1; i < amt; i++) {
      float y1 = wave[i - 1] * height/2;
      float y2 = wave[i] * height/2;
      float dy = (wave[i] + wave[i - 1]) / 2;
      float b = 64 + 64 * dy;
      stroke(b, 128, 128);
      line(i * w, y1, i * w + w, y2);
    }
    for (int i = 1; i < max.size(); i++) {
      float y1 = wave[i - 1] * height/2;
      float y2 = wave[i] * height/2;
      float dy = (wave[i] + wave[i - 1]) / 2;
      float b = 64 + 64 * dy;
      stroke(b, 128, 128);
      line(i * w, y1, i * w + w, y2);
    }
    
    popMatrix();
  }

  /*void fix(int i) {
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
   }*/
}