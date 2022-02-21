import oscP5.*;
import netP5.*;
OscP5 oscP5;
//NetAddress ip_port;
int PORT = 57120;

color c1, c2, c3, c4;
color [] c = {c1, c2, c3, c4};

ParticleSystem ps;
int Nparticles=6000;
void setup(){
  fullScreen(P2D);
  //size(1280,720);
  c1 = color(192, 192, 192);
  c2 = color(255, 204, 0);
  c3 = color(170, 1, 20);
  c4 = color(0, 75, 144);
  c[0] = c1;
  c[1] = c2;
  c[2] = c3;
  c[3] = c4;
  
  
  oscP5 = new OscP5(this,PORT);
  oscP5.plug(this, "prova", "/keypressed");
  
  
  ps=new ParticleSystem();
  for(int p=0; p<Nparticles; p++){
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
  if(theOscMessage.isPlugged()==false) {
    println("## received an osc message");
  }
}

void draw(){
  background(0);
  
  /*PVector mouse = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
  if (mouse.x > width) {
      mouse.x = 0;
    } 
    else if (mouse.x < 0) {
      mouse.x = width;
    }

    if (mouse.y > height) {
      mouse.y = 0;
    } 
    else if (mouse.y < 0) {
      mouse.y = height;
    }*/
  //ps.origin=new PVector(width/2, height/2);
  
  PVector center = new PVector(width/2,height/2);
  ps.action(center);
  //println(c);
}
