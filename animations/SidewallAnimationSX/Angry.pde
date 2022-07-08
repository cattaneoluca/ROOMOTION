class Angry implements StateEmotion {
  
  private color c = color(255, 86, 7);  // yellow - red

  void setSpeed(){
    ps.HmaxSpeed = 5;
    ps.VmaxSpeed = 3.5;
  }  
  
  public color getColor(){return c;}
  
}
