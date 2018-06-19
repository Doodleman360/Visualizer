class Lines extends Frame {
  float size = in.bufferSize();
  float cols = 8; // must be multiple of 2
  float per = size/cols;
  float dx, dy;
  ArrayList<ArrayList<Float[]>> nums;
  float a2s;

  Lines() {
    load();
    nums = new ArrayList<ArrayList<Float[]>>((int)cols);
    for (int i = 0; i < cols; i ++) {
      ArrayList<Float[]> tmp = new ArrayList<Float[]>((int)a2s);
      for (int i1 = 0; i1 < a2s; i1++) {
        Float[] ns = new Float[(int)per];
        for (int i2 = 0; i2 < per; i2++) {
          ns[i2] = 0f;
        }
        tmp.add(ns);
      }
      nums.add(tmp);
    }
  }

  void load() {
    dy = height/per;
    dx = width/cols;
    a2s = 200/cols;
    if (a2s < 25) a2s = 25;
    colorMode(RGB);
  }

  void frame() {

    if (beat.isOnset()) ;
    background(0);

    stroke(255);
    strokeWeight(2);
    pushMatrix();
    translate(0, 0);

    for (int i = 0; i < cols; i++) {
      if (nums.get(i).size() >= a2s) { 
        nums.get(i).remove(nums.get(i).size() - 1);
      }
    }

    for (int i1 = 0; i1 < cols; i1++) {
      nums.get(i1).add(0, new Float[(int)per]);
      for (int i2 = 0; i2 < per; i2++) {
        nums.get(i1).get(0)[i2] = in.mix.get(i2 + (int)(i1 * per));
      }
    }

    stroke(255, 0, 0);
    strokeWeight(1);
    noStroke();
    for (int i = 0; i < cols; i++) {
      if (i%3 == 0) {
        fill(255, 0, 0, 32);
      } else if (i%3 == 1) {
        fill(0, 255, 0, 32);
      } else {
        fill(0, 0, 255, 32);
      }
      rect(i * dx + 1, 0, i * dx + dx, height);
    }

    stroke(255);
    strokeWeight(1);
    for (int i = 0; i < cols; i ++) {
      for (int i2 = 0; i2 < per; i2++) {
        for (int i1 = 1; i1 < a2s; i1++) {
          float n1 = nums.get(i).get(i1 - 1)[i2];
          float n2 = nums.get(i).get(i1)[i2];
          float y = dy * i2 + dy / 2;
          float x1 = (i * dx) + (dx/(a2s - 1) * (float)i1) ;
          float x2 = x1 - dx/(a2s - 1);
          line(x1, y + n1 * dy * 2, x2, y + n2 * dy * 2);
        }
      }
    }

    popMatrix();
  }
}
