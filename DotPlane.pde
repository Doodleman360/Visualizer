class DotPlane extends Frame {
  float scale = 10;
  int cols, rows;
  ArrayList<Particle> particles = new ArrayList<Particle>();

  DotPlane() {
    rows = floor(width/scale);
    cols = floor(height/scale);
    for (int i = 0; i < 10000; i++) {
      particles.add(new Particle());
    }
  }

  void frame() {
    background(0);
    pushMatrix();
    translate(width/2, height/2);
    rotateX(PI/3);
    translate(-rows/2, -cols/2);

    if (beat.isOnset()) {
      for (Particle part : particles) {
        part.applyForce(new PVector(0, 0, random(400)-200));
      }
    }

    for (Particle part : particles) {
      part.update();
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
  Particle() {
    pos = new PVector(random(width)-width/2, random(height)-height/2, 200);
    Ppos = pos.copy();
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    maxspeed += random(1);
  }

  void update() {
    fix();
    vel.add(acc);
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
    //edges();
  }

  void fix() {
    vel = (new PVector(0, 0, (-pos.z)/50));
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void show() {
    strokeWeight(5);
    stroke(map(pos.x, 0, width, 0, 255), map(pos.y, 0, height, 0, 255), 100, 255);
    point(pos.x, pos.y, pos.z);
    Ppos = pos.copy();
  }
}