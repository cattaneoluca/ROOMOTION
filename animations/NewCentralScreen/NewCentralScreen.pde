import oscP5.*;
import netP5.*;
OscP5 oscP5;

//NetAddress ip_port;
int PORT = 57120;

color c1, c2, c3, c4;
color [] c = {c1, c2, c3, c4};

EmoPixels ep;
PImage originalArt, roomArt;

void setup(){
  background(0);
  fullScreen(P2D);
  //size(1050, 1050);
  imageMode(CENTER);
  originalArt = loadImage("potalisa.jpg");
  image(originalArt, width/2, height/2);
  frameRate(60);
  
  //c1 = color(192, 192, 192);
  //c2 = color(255, 204, 0);
  //c3 = color(170, 1, 20);
  //c4 = color(0, 75, 144);
  //c[0] = c1;
  //c[1] = c2;
  //c[2] = c3;
  //c[3] = c4;
  
  
  oscP5 = new OscP5(this,PORT);
  oscP5.plug(this, "prova", "/keypressed");
  
  ep = new EmoPixels();

}


public void prova(float p1, float p2, float p3, float p4) {
  //println("probabilità:"+p1+"," +p2+ "," +p3+ "," +p4);
  float[] values = { p1, p2, p3, p4 };  // Create an array of ints

  ep.p1 = values[0];
  ep.p2 = values[1];
  ep.p3 = values[2];
  ep.p4 = values[3];
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.isPlugged()==false) {
    println("## received an osc message");
  }
}

void draw(){
  background(0);
  
  
  roomArt = ep.emotiveArt(originalArt);
  ep.currentArt(roomArt);

}
