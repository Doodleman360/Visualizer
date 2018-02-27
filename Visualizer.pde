import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

static Minim minim;
static AudioInput in;
static AudioPlayer player;
static BeatDetect beat;
static AudioMetaData meta;
int time;
int wait = 10000;
int mode = 0;
ArrayList<Frame> frames = new ArrayList<Frame>();
boolean fps = false;
int last = 0;
boolean updateFps = false;
boolean paused = false;

void setup() {
  fullScreen(P3D);
  textAlign(CENTER, CENTER);
  textSize(20);
  
  background(0);
  text("Made by: Doodleman, using the Minim library\nContributors: Goofables", width/2, height/4);

  minim = new Minim(this);
  //player = minim.loadFile("0"+(int)random(9)+".mp3");

  in = minim.getLineIn();

  //meta = player.getMetaData();
  beat = new BeatDetect();//(player.bufferSize(), player.sampleRate());  <- mode 2

  frames.add(new DotLine());     // 0  a
  frames.add(new Land());        // 1  b
  frames.add(new Sphere());      // 2  c
  frames.add(new SphereLine());  // 3  d
  frames.add(new DotCircle());   // 4  e
  //frames.add(new Matrix());    // 
  frames.add(new Waves());       // 5  f
  frames.add(new Dots());        // 6  g
  frames.add(new Dots4());       // 7  h
  frames.add(new Lines());       // 8  i
  frames.add(new DotArc());      // 9  j
  frames.add(new Window());      // 10 k
  frames.add(new Wave());        // 10 l

  noCursor();
  //player.play();
}

void draw() {
  if (paused) return;
  beat.detect(in.mix);

  /*if (millis() - time >= wait) {
   mode = 6;//(int)random(frames.size());
   if (mode > frames.size()) {
   mode = 0;
   }
   time = millis();
   }*/
  frames.get(mode).frame();

  if (fps) {
    int now = millis();
    int fps = 1000/(now - last);
    last = now;
    if (updateFps) {
      updateFps = false;
      String txt = String.valueOf(fps);
      fill(0);
      noStroke();
      rect(30, 42, 50, 20);
      fill(255);
      text(txt, 50, 50);
    } else updateFps = true;
  }
}

void keyPressed() {
  //println("Code: " + keyCode + " Key: '" + key + "'");
  if (48 <= keyCode && keyCode <= 57) { // key 0 - 9
    mode = keyCode - 48; // 48 = 0
  } else if (65 <= keyCode && keyCode <= 90) { // key a - z
    mode = keyCode - 65; // 65 = a
  } else if (key == ENTER | key == RETURN) {
    paused = !paused;
    return;
  } else switch(keyCode) {
  case 38: // up
  case 39: // Right
    mode += 1;
    break;
  case 37: // Left
  case 40: // Down
    mode -= 1;
    break;
  case 96: // toggle fps (`)
    fps = !fps;
    println("Debug: " + fps);
    return;
  case 92: 
    for (int i = 0; i < frames.size(); i++) {
      if (frames.get(i) instanceof Lines) ((Lines)frames.get(i)).toggle(); 
      if (frames.get(i) instanceof DotArc) ((DotArc)frames.get(i)).toggle();
    }
    return;
  default:
    return;
  }
  // make sure 0 <= mode < frames.size()
  if (mode >= frames.size()) mode = 0; 
  if (mode < 0) mode = frames.size() - 1; 
  background(0); 
  frameRate(60); 
  paused = false;
}