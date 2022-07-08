import netP5.*;
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
/*float prob1,prob2,prob3,prob4;
float [] probs = {prob1,prob2,prob3,prob4};*/
void setup () {
  oscP5 = new OscP5(this,57120);
  myRemoteLocation = new NetAddress("localhost",57120);
  
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
  OscMessage myMessageAmp = new OscMessage("/keypressedAmp");
 /*float prob = 1;
 float p1 = random(0,0.6);
 prob -= p1;
 float p2 = random(0,prob);
 prob -= p2;
 float p3 = random(0,prob);
 float p4 = prob - p3;*/
 float p1 = 0;
 float p2 = 0;
 float p3 = 0;
 float p4 = 1;
 
 
 
  /*myMessage.add(random(0,1));
  myMessage.add(random(0,1));
  myMessage.add(random(0,1));
  myMessage.add(random(0,1));*/
  float amp1 = 0.12;
  float amp2 = 0.01;
  float amp3 = 0.2;
  float amp4 = 0.02;
  float amp5 = 0.05;
  float amp6 = 0.1;
  float amp7 = 0.18;
  float amp8 = 0.03;
  float amp9 = 0.055;
  float amp10 = 0.13;
  float amp11 = 0.08;
  float amp12 = 0.025;
  float [] amp = {amp1, amp2, amp3, amp4, amp5, amp6, amp7, amp8, amp9, amp10, amp11, amp12};
  float [] probs = {p1, p2, p3, p4};
  myMessage.add(probs);
  myMessageAmp.add(amp);
  
  //myMessage.add(p1);
  //myMessage.add(p2);
  //myMessage.add(p3);
  //myMessage.add(p4);
  
  
  

  /* invio messaggio */
  oscP5.send(myMessage,myRemoteLocation);
  oscP5.send(myMessageAmp,myRemoteLocation);
}
