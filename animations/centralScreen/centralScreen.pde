import oscP5.*;
import netP5.*;
OscP5 oscP5;
//NetAddress ip_port;
int PORT = 57120;

PImage originalArt;
Drawer main;
int imageWidth, imageHeight, borderSx, borderDx, FRAMERATE;

//init colours
color angryCol, happyCol, neutralCol, sadCol;
color[] c = new color[4];

void setup() {
  size(1000, 1000);
  FRAMERATE = 100;
  frameRate(FRAMERATE);

  originalArt = loadImage("potalisa.jpg");
  imageWidth = originalArt.width;
  imageHeight = originalArt.height;
  borderSx = width/2 - imageWidth/2;
  borderDx = width/2 + imageWidth/2;
  imageMode(CENTER);
  noStroke();
  background(0);
  
  angryCol = color(255, 86, 7);
  happyCol = color(255, 193, 0);
  neutralCol = color(60, 179, 113);
  sadCol = color(0, 0, 205);
  c[0] = angryCol;
  c[1] = happyCol;
  c[2] = neutralCol;
  c[3] = sadCol; 
  

  oscP5 = new OscP5(this, PORT);
  oscP5.plug(this, "prova", "/keypressed");
  oscP5.plug(this, "prova1", "/keypressedAmp");

  main = new Drawer();
  image(originalArt, width/2, height/2);
}

void draw() {
  background(0);
  image(originalArt, width/2, height/2);
  main.action();
}




// auxiliary functions
public void prova(float [] p) {

  float [] values = p;
  main.setColor(values);

  println(values);
}


/*public void prova1 (float [] v) {
 // this function is not required in this script
 float [] vamp = v;
 for (int j=0; j<vamp.length; j++){
 //ps.amp[j] = vamp[j];
 ps.ap.append(vamp[j]);
 }
 println(vamp);
 }*/

void oscEvent(OscMessage theOscMessage, OscMessage theOscMessage1) {

  String msgType = theOscMessage.addrPattern();

  if (msgType.equals("/keypressed")) {
    byte [] msg = theOscMessage.get(0).blobValue();
    float [] msgf = float(msg);
    this.prova(msgf);
  }

  if (msgType.equals("/keypressedAmp")) {
    // not used in this script
    /*byte [] msgA = theOscMessage1.get(0).blobValue();
     float [] msgfA = float(msgA);
     this.prova1(msgfA);*/
  }
}
