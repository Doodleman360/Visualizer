class SphereLine extends Frame {
  float[] array;
  float Rfade, Gfade, Bfade, Afade, R = 0;

  SphereLine() {
    array = new float[40];
  }
  @Override
    public void frame() {
    background(0);
    fill(0, 0, 0, Afade);
    //rect(0,0,width,height);

    //Rfade = map(in.position(), 0, in.length(), 60, 255);

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

    //slow decrese of size
    for (int i = 0; i < array.length; i++) {
      array[i] *= 0.9;
    }
    //draw circles
    noStroke();
    //stroke(0,0,0);
    fill(Rfade, Gfade, Bfade);
    pushMatrix();
    translate(width/2, height/2, -600);
    float r = 0;
    for (float i : array) {
      r += i;
    }
    r/=(array.length*10);
    rotateY(R+=(r));
    rotateZ(2*R);
    rotateX(2*R/3);
    int k = 0;
    for (int i = 0; i < in.bufferSize() - 1; i+=in.bufferSize()/array.length) {
      ball(i, in.bufferSize()/array.length, k);
      k++;
    }
    popMatrix();
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
      pushMatrix();
      translate(x1-width/2, 0);
      sphere(array[k]*(height/2));
      popMatrix();
    }
  }
}
