import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
/*float prob1,prob2,prob3,prob4;
float [] probs = {prob1,prob2,prob3,prob4};*/

void setup () {
  oscP5 = new OscP5(this,57120);
  myRemoteLocation = new NetAddress("127.0.0.1",57120);
  
  size(400,400);
  background(0);
  
  /*probs[0] = 0.5;
  probs[1] = 0.25;
  probs[2] = 0.1;
  probs[3] = 0.15;*/
}

void draw() {
  //background(0);

}

void mousePressed(){
  OscMessage myMessage = new OscMessage("/keypressed");
 float prob = 1;
 float p1 = random(0,0.6);
 prob -= p1;
 float p2 = random(0,prob);
 prob -= p2;
 float p3 = random(0,prob);
 float p4 = prob - p3;
 
  /*myMessage.add(random(0,1));
  myMessage.add(random(0,1));
  myMessage.add(random(0,1));
  myMessage.add(random(0,1));*/
  myMessage.add(p1);
  myMessage.add(p2);
  myMessage.add(p3);
  myMessage.add(p4);
  
  

  /* invio messaggio */
  oscP5.send(myMessage,myRemoteLocation);
}
