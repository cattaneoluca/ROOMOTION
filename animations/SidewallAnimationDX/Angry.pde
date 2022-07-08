class Angry implements StateEmotion {
  
  private color c = color(255, 86, 7);  // yellow - red

  void setSpeed(){
    ps.HmaxSpeed = 5;
    ps.VmaxSpeed = 1.25;
  }  
  
  public color getColor(){return c;}
  
}
