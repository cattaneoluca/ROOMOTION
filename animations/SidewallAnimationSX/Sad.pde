class Sad implements StateEmotion {
  
  private color c = color(0, 0, 205);  // medium blue

  void setSpeed(){
    ps.HmaxSpeed = 2.75;
    ps.VmaxSpeed = 1;
  }  
  
  public color getColor(){return c;}
  
}
