
class Particle{
  PVector location, velocity, acceleration;
  float radius_circle, lifespan, maxspeed, maxforce;
  color colour;
  
  Particle(PVector location, float radius_circle, float lifespan, color colour){
    this.location= location.copy();
    this.velocity = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    this.velocity.mult(20);
    /*if(this.velocity.mag()>15){
      this.velocity.mult(15/this.velocity.mag());  
    }*/

    this.acceleration = new PVector();
    this.radius_circle=radius_circle;
    this.lifespan = lifespan;
    this.colour = colour;
    this.maxspeed = 4.5;
    this.maxforce = 0.1;
    
  }
  
  void planning(){    
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
    this.checkEdges();
  }
  
  void applyForce(PVector force){    
    this.acceleration.add(force);
  }
  
  
  void checkEdges() {

    if (location.x >= width) {
      velocity.x = velocity.x * (-1) ;
    } 
    else if (location.x < 0) {
      velocity.x = velocity.x * (-1) ;
    }

    if (location.y > height) {
      velocity.y = velocity.y * (-1) ;
    } 
    else if (location.y < 0) {
      velocity.x = velocity.x * (-1) ;
    }
  }
  
  void action(){
    this.planning();    
    fill(this.colour, map(this.lifespan,0,200,0,255));
    noStroke();
    ellipse(this.location.x, this.location.y, this.radius_circle, this.radius_circle);    
  }
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    
    applyForce(steer);
  }
  
  
  boolean isDead(){
    return this.lifespan<=0;
  }
}
