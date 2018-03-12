class DotPlane implements Frame{
  float inc = 0.01;
  float scale = 10;
  int cols, rows;
  float zoff = 0;
  ArrayList<Particle> particles = new ArrayList<Particle>();

  DotPlane() {
    //size(500, 500);
    fullScreen(P3D);
    noCursor();
    background(0);
    rows = floor(width/scale);
    cols = floor(height/scale);
    for (int i = 0; i < 1000; i++) {
      particles.add(new Particle());
    }
  }

  void frame() {
    pushMatrix();
    translate(width/2, height/2);
    rotateX(PI/3);
    translate(-rows/2, -cols/2);
    fill(0, 10);
    noStroke();
    rect(-1, -1, width+1, height+1);
    for (int y = 0; y < rows + 1; y++) {
      for (int x = 0; x < cols + 1; x++) {

      }
    }

    for (Particle part : particles) {
      //part.update();
      part.show();
      //part.follow(flow);
    }
    popMatrix();
  }
}

class Particle {
  PVector pos, vel, acc, Ppos;
  float maxspeed = 4;
  float inc = 0.01;
  float scale = 10;
  int cols, rows;
  float zoff = 0;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector[] flow;
  float mag = 1;
  Particle() {
    pos = new PVector(random(width)-width/2, random(height)-height/2, 0);
    Ppos = pos.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxspeed += random(1);
  }

  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
    //edges();
  }

  void follow (PVector[] flow) {
    int x = floor(pos.x/scale);
    int y = floor(pos.y/scale);
    int index = (x + y * cols);
    PVector force = flow[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void show() {
    strokeWeight(2);
    stroke(map(pos.x, 0, width, 0, 255), map(pos.y, 0, height, 0, 255), 100, 255);
    point(pos.x, pos.y,pos.z);
    Ppos = pos.copy();
  }
}