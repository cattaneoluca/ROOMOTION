import oscP5.*;
import netP5.*;
OscP5 oscP5;
//NetAddress ip_port;
int PORT = 57120;


ParticleSystem ps;
int Nparticles=3500;

AudioStream audio;

void setup(){
  fullScreen(P2D);
  //size(1280,720);
  frameRate(40);
  
  //init OSC server  
  oscP5 = new OscP5(this,PORT);
  oscP5.plug(this, "prova", "/keypressed");
  oscP5.plug(this, "prova1", "/keypressedAmp");
  
  //init particle system
  ps=new ParticleSystem();
  for(int p=0; p<Nparticles; p++){
    ps.addParticle();
  }
  
  audio = new AudioStream(this);
  
  background(0);
}


PVector computeWind(){  
  float energy= audio.getEnergy();
  return new PVector(random(-energy, energy), 0); // decide la direzione del vento!
}

float energyOnly() {
  float energy = audio.getEnergy();
  //println(energy);
  return energy*10000;
}

//public void prova(float [] p, float [] v) {
  
//  float [] values = p;
//  float [] vamp = v;
//  ps.p1 = values[0];
//  ps.p2 = values[1];
//  ps.p3 = values[2];
//  ps.p4 = values[3];
  
//  for (int j=0; j<5; j++){
//    ps.amp[j] = vamp[j];
//  }
//  println(values);
//  println(vamp);

  
//}

public void prova(float [] p) {
  
  float [] values = p;
  ps.setEmotion(values);

  //println(values);

  
}


public void prova1 (float [] v) {

  float [] vamp = v;
  for (int j=0; j<vamp.length; j++){
    //ps.amp[j] = vamp[j];
    ps.ap.append(vamp[j]);
  }
  // println(vamp);
}

void oscEvent(OscMessage theOscMessage, OscMessage theOscMessage1){
  
  String msgType = theOscMessage.addrPattern();
  
  if(msgType.equals("/keypressed")){
    println("message received \n");
    byte [] msg = theOscMessage.get(0).blobValue();
    float [] msgf = float(msg);
    this.prova(msgf);
    println("message received \n");
  }
  
  if(msgType.equals("/keypressedAmp")){
    byte [] msgA = theOscMessage1.get(0).blobValue();
    float [] msgfA = float(msgA);
    this.prova1(msgfA);
  }
}

//void oscEvent(OscMessage theOscMessage) {
//  if(theOscMessage.isPlugged()==false) {
//    println("## received an osc message");
//  }
//}

void draw(){
  background(0);
  
  PVector wind = new PVector(0,0);//computeWind();
  float alpha = energyOnly();
  ps.brightness = map(alpha, 0, alpha, 100, 200);
  ps.action(wind);
  //println(c);
}


// ********************* for testing **************************
// pressing 1,2,3,4 the respective emotion will be somulated as the prevalent
// speeds taken from Russel circumplex model (https://www.researchgate.net/figure/Russells-circumplex-model-13_fig5_307909024)
void keyPressed() {
  // 1 -> HAPPY 
  if (keyCode == '1') {
    //ps.HmaxSpeed = 3.5;
    //ps.VmaxSpeed = 6;
    
    ps.emotion = new Happy();
    ps.emotion.setSpeed();
  }
  // 2 -> ANGRY
  else if (keyCode == '2') {
    //ps.HmaxSpeed = 5;
    //ps.VmaxSpeed = 3.5;
    ps.emotion = new Angry();
    ps.emotion.setSpeed();
  }
  // 3 -> SAD
  else if (keyCode == '3') {
    //ps.HmaxSpeed = 2.75;
    //ps.VmaxSpeed = 2.5;
    ps.emotion = new Sad();
    ps.emotion.setSpeed();
  }
  // 4 -> NEUTRAL
  else if (keyCode == '4') {
    //ps.HmaxSpeed = 3.5;
    //ps.VmaxSpeed = 3.5;
    ps.emotion = new Neutral();
    ps.emotion.setSpeed();
  }
  
  /*
  if (keyCode == ENTER) {
    if(toggle) {
      ps.maxspeed = 3;
      toggle = !toggle;
     }
     else {
       ps.maxspeed = 4.5;
       toggle = !toggle;
     }
  }*/
}
