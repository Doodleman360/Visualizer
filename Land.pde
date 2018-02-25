class Land implements Frame {
  int cols, rows;
  int scale = 20;
  int up = 120;
  int w = 2500;
  int h = 1600;
  float Rfade, Gfade, Bfade, Afade;

  float[][] land;
  float[] red, green, blue;

  Land() {

    cols = w / scale;
    rows = h / scale;

    land = new float[cols][rows];
    red = new float[rows];
    green = new float[rows];
    blue = new float[rows];
    for (int y = rows-1; y > 0; y--) {
      red[y] = 0;
      green[y] = 0;
      blue[y] = 0;
      for (int x = 0; x < cols; x++) {
        land[x][y] = 0;
      }
    }
  }
  void frame() {

    for (int y = rows-1; y > 0; y--) {
      for (int x = 0; x < cols; x++) {
        land[x][y] = land[x][y-1];
      }
    }
    for (int x = 0; x < cols; x++) {
      if (land[x][0] < abs(in.mix.get((int)map(x, 0, cols, 0, in.bufferSize()))*150)) {
        land[x][0] = abs(in.mix.get((int)map(x, 0, cols, 0, in.bufferSize()))*150);
      } else {
        land[x][0] = land[x][1]*0.9;
      }
    }

    //Rfade = map(in.position(), 0, in.length(), 60, 255);
    strokeWeight(1);
    if (beat.isOnset()) {
      Afade = 50;
      if (random(3)<2) {
        Bfade = 255;
      } else if (random(2)<1) {
        Gfade = 255;
      } else {
        Rfade = 255;
      }
    }
    //fades
    Rfade *= 0.99;
    if ( Rfade < 60 ) Rfade = 60;

    Gfade *= 0.99;
    if ( Gfade < 60 ) Gfade = 60;

    Bfade *= 0.99;
    if ( Bfade < 60 ) Bfade = 60;

    Afade *= 0.999;
    if ( Afade < 1 ) Afade = 1;

    for (int y = rows-1; y > 0; y--) {
      red[y] = red[y-1];
      blue[y] = blue[y-1];
      green[y] = green[y-1];
    }
    red[0] = Rfade;
    green[0] = Gfade;
    blue[0] = Bfade;

    background(0);
    //noFill();

    translate(width/2, height/2);
    rotateX(PI/3);
    translate(-w/2, -h/2);

    for (int y = 0; y < rows-1; y++) {
      //stroke(red[y], green[y], blue[y]);
      stroke(0);
      fill(red[y], green[y], blue[y]);
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        vertex(x*scale, y*scale, land[x][y]);
        vertex(x*scale, (y+1)*scale, land[x][y+1]);
      }
      endShape();
    }
  }
}