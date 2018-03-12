class DotCircle extends Frame {
  public void frame() {
    background(0);
    float theta = 0;
    int x = 0;
    int y = 0;
    float r = 200;
    stroke(255);
    strokeWeight(5);
    pushMatrix();
    translate(width/2, height/2);
    //translate(-width/2,-height/2);
    for (int i = 0; i <= in.bufferSize()-1; i ++) {
      theta = map(i, 0, in.bufferSize(), 0, PI);
      r = 300+(in.mix.get(i)*300);
      point(x+r*cos(theta), y+r* sin(theta));
    }
    for (int i = 0; i <= in.bufferSize()-1; i ++) {
      theta = map(i, in.bufferSize(), 0, PI, TWO_PI);
      r = 300+(in.mix.get(i)*300);
      point(x+r*cos(theta), y+r* sin(theta));
    }
    popMatrix();
  }
}