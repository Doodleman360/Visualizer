class DotLine extends Frame {
  float[] array = new float[15];
  float Rfade, Gfade, Bfade, Afade;

  public void frame() {
    //background(0);
    noStroke();
    fill(0, 0, 0, Afade);
    rect(0, 0, width, height);

    Rfade = 0;//map(in.position(), 0, in.length(), 60, 255);

    if (beat.isOnset()) {
      Afade = 50;
      if (random(2)<1) {
        Bfade = 255;
      } else {
        Gfade = 255;
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

    //slow decrese of size
    for (int i = 0; i < array.length; i++) {
      array[i] *= 0.9;
    }
    //draw circles
    noStroke();
    fill(Rfade, Gfade, Bfade);
    int k = 0;
    for (int i = 0; i < in.bufferSize() - 1; i+=in.bufferSize()/array.length) {
      ball(i, in.bufferSize()/array.length, k);
      k++;
    }
  }

  public void ball(int i, int amount, int k) {
    if (i + amount < in.bufferSize()) {

      float x1 = map( i + (amount/2), 0, in.bufferSize(), 0, width );

      float avaM = 0;
      for (int j = i; j < i + amount; j++) {
        avaM += abs(in.mix.get(j));
      }
      avaM = avaM / amount;
      if (avaM > array[k]) {
        array[k] = avaM;
      }

      ellipse(x1, height/2, array[k]*(height/2), array[k]*(height/2));
    }
  }
}