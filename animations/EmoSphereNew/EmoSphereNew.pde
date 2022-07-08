import oscP5.*;
import netP5.*;
OscP5 oscP5;
//NetAddress ip_port;
int PORT = 57120;

color c1, c2, c3, c4;
color [] c = {c1, c2, c3, c4};

ParticleSystem ps;
int Nparticles=9000;

// only for testing ***********
float speedBias, speedsCoeff[];
// ****************************


void setup() {
  //only for testing ***********************************
  speedBias = 1;
  speedsCoeff = new float[5];
  speedsCoeff[0] = -1;
  speedsCoeff[1] = -0.3;
  speedsCoeff[2] = -0;
  speedsCoeff[3] = 0.3;
  speedsCoeff[4] = 1;
  // ******************************************

  frameRate(40);
  fullScreen(P2D);
  //size(1280,720);
  c1 = color(255, 86, 7);
  c2 = color(255, 193, 0);
  c3 = color(60, 179, 113);
  c4 = color(0, 0, 205);
  c[0] = c1;
  c[1] = c2;
  c[2] = c3;
  c[3] = c4;


  oscP5 = new OscP5(this, PORT);
  oscP5.plug(this, "prova", "/keypressed");


  ps=new ParticleSystem(this);
  for (int p=0; p<Nparticles; p++) {
    ps.addParticle();
  }
  background(0);
}

public void prova(float p1, float p2, float p3, float p4) {
  //println("questi bastardi:"+p1+"," +p2+ "," +p3+ "," +p4);
  float[] values = { p1, p2, p3, p4 };  // Create an array of ints
  /*float d = max(values);                // Sets 'd' to 362
   
   for (int i=0; i<4; i++){
   if (values[i]==d){
   ps.colour = c[i];
   }
   }*/
  ps.p1 = values[0];
  ps.p2 = values[1];
  ps.p3 = values[2];
  ps.p4 = values[3];
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    println("## received an osc message");
  }
}

void draw() {
  background(0);

  //ps.origin=new PVector(width/2, height/2);
  PVector center;
  if (mousePressed) {
    center = new PVector(mouseX, mouseY);
  } else {
    center = new PVector(width/2, height/2);
  }
  ps.action(center);
  //println(c);
}

// ********************* for testing **************************
void keyPressed() {

  if (keyCode == ENTER) {
    int idx = (int) random(0, 5);
    println(idx);
    println(speedsCoeff[idx]);
    float newMaxSpeed = 4.5 + speedBias * speedsCoeff[idx];
    println(newMaxSpeed);
    ps.SetMaxSpeed(newMaxSpeed);
  }
}
// *********************************************************
