class Neutral implements StateEmotion {
  
  private color c = color(60, 179, 113);  // medium seagreen

  void setSpeed(){
    ps.HmaxSpeed = 3.5;
    ps.VmaxSpeed = 1.5;
  }  
  
  public color getColor(){return c;}
  
}


  //c1 = color(192, 192, 192);
  //c2 = color(255, 204, 0);
  //c3 = color(170, 1, 20);
  //c4 = color(0, 75, 144);
