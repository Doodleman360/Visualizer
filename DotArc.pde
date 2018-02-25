class DotArc implements Frame {
  float amt = in.bufferSize();
  float[] mix = new float[(int)amt];
  boolean vertical = false;

  void frame() {
    colorMode(RGB);

    if (beat.isOnset()) {
      background(0);
    } else {
      fill(0, 128);
      noStroke();
      rect(0, 0, width, height);
    }
    pushMatrix();
    translate(width/2, height/2);
    rotate(PI);

    float lx1=0, ly1=0, lx2=0, ly2=0;
    float rx1=0, ry1=0, rx2=0, ry2=0;

    strokeWeight(4);
    for (int i = 1; i < amt; i+= 2) {
      if (i < amt*2/5) {      
        stroke(255, 255 - 255 * i/(amt*2/5), 255);
      } else if (i < amt * 2/3) {
        stroke(255 - 255 * (i - amt*2/5)/(amt*2/5), 0, 255);
      } else {
        stroke(0, 0, 255 - 128 * (i - amt*4/5)/(amt/5));
      }

      float li1 = abs(in.left.get(i));
      float li2 = abs(in.left.get(i - 1));

      float ri1 = -abs(in.right.get(i));
      float ri2 = -abs(in.right.get(i - 1));

      lx2 = cos(li1 * PI) * li2 * 1000;
      ly2 = sin(li1 * PI) * li2 * 1000;

      rx2 = cos(ri1 * PI) * ri2 * 1000;
      ry2 = sin(ri1 * PI) * ri2 * 1000;

      if (vertical) {
        point(lx2, ly2);
        point(lx2, -ly2);
        point(rx2, ry2);
        point(rx2, -ry2);
      } else {
        point(1.25 * ly2, lx2);
        point(1.25 * ly2, -lx2);
        point(-1.25 * ry2, rx2);
        point(-1.25 * ry2, -rx2);
      }
      lx1 = lx2;
      ly1 = ly2;
      rx1 = rx2;
      ry1 = ry2;
    }
    popMatrix();
  }
  void toggle() {
    vertical = !vertical;
  }
}