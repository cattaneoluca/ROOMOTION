class ColoredShape{

  private PVector pos;
  private float initialLife;
  private float lifespan;
  color colour;
  
  ColoredShape(PVector location, int lifespan, color col) {
    this.pos = location.copy();
    this.initialLife = lifespan;
    this.lifespan = lifespan;
    this.colour = col;
  }
  
  public void drawShape(){
    fill(this.colour, map(this.lifespan,0,this.initialLife,0,30));
    noStroke();
    ellipse(this.pos.x,this.pos.y,80,80);
    
    this.lifespan -= 1;
  }
  
  public boolean isDead() {
    if(this.lifespan <=0) return true;
    else return false;
  }

}
