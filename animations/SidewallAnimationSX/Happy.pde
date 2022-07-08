class Happy implements StateEmotion {
  
  private color c = color(255, 193, 0); // red - yellow

  void setSpeed(){
    ps.HmaxSpeed = 3.5;
    ps.VmaxSpeed = 1.75;
  }  
  
  public color getColor(){return c;}
  
}
