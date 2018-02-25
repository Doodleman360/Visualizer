class Sphere implements Frame {

  PVector[][] globe;
  int total = 200;
  float offset = 0;
  float rotate = 0;
  float[] mix;

  Sphere() {
    colorMode(HSB);
    noStroke();

    globe = new PVector[total+1][total+1];
    mix = new float[total+1];
  }
  void frame() {
    colorMode(HSB);
    noStroke();
    translate(width/2, height/2);
    rotateX(rotate);
    rotateY(rotate);
    rotateZ(PI * rotate);
    rotate+=0.01;
    background(0);
    lights();
    float r = 200;
    //calc
    for (int i = 0; i < total+1; i++) {
      float lat = map(i, 0, total, 0, PI);
      mix[i] *= 0.9;
      if (mix[i] < in.mix.get((int)map(lat, 0, PI, 0, in.bufferSize()-1))) {
        mix[i] = in.mix.get((int)map(lat, 0, PI, 0, in.bufferSize()-1));
      }
      for ( int j = 0; j < total+1; j++) {
        float lon = map(j, 0, total, 0, TWO_PI);
        float x = ((r * (mix[i]))+r) * cos(lon) * sin(lat);
        float y = ((r* (mix[i]))+r) * sin(lon) * sin(lat);
        float z = ((r* (mix[i]))+r) * cos(lat);
        globe[i][j] = new PVector(x, y, z);
      }
    }
    //draw
    offset+=5;
    for (int i = 0; i < total; i++) {
      float hu = map(i, 0, total, 0, 255*6);
      fill((hu + offset )% 255, 255, 255);
      beginShape(TRIANGLE_STRIP);
      for ( int j = 0; j < total+1; j++) {
        PVector v1 = globe[i][j];
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
    }
  }
  float a = 1;
  float b = 1;
  
  float superShape(float theda, float m, float n1, float n2, float n3) {
    float t1 = abs((1/a)*cos(m*theda/4));
    t1 = pow(t1, n2);
    float t2 = abs((1/b)*sin(m*theda/4));
    t2 = pow(t2, n3);
    float t3 = t1 + t2;
    float r = pow(t3, -1/n1);

    return r;
  }
}