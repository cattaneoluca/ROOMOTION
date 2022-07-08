
class Particle {
  PVector location, velocity, acceleration;
  float radius_circle, lifespan, maxspeed, maxforce, Hmaxspeed, Vmaxspeed;
  color colour;

  Particle(PVector location, float radius_circle, float lifespan, color colour,
    float Hspeed, float Vspeed) {
    this.location= location.copy();
    this.velocity = new PVector(random(0.1, 0.3), random(-0.1, 0.1));
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
    this.Hmaxspeed = Hspeed;
    this.Vmaxspeed = Vspeed;
  }

  void planning() {
    this.applyForce(new PVector(0, random(-0.005, 0.005)));
    this.velocity.add(this.acceleration);
    this.velocity.x = min(Hmaxspeed, this.velocity.x);
    this.velocity.y = this.sign(this.velocity.y) *
      min(Vmaxspeed, abs (this.velocity.y));
    this.location.add(this.velocity);
    this.acceleration.mult(0);
    this.checkEdges();
  }

  void applyForce(PVector force) {
    this.acceleration.add(force);
  }


  void checkEdges() {

    if (location.x >= width) {
      this.lifespan = 0 ;
    } else if (location.x < 0) {
      velocity.x = velocity.x * (-1) ;
    }

    if (location.y > height) {
      this.lifespan = 0 ;
    } else if (location.y < 0) {
      this.lifespan = 0 ;
    }
  }

  void action() {
    this.planning();
    fill(this.colour, map(this.location.x, width, 0, 0, 255));
    noStroke();
    ellipse(this.location.x, this.location.y, this.radius_circle, this.radius_circle);
  }

  //compute and apply steering force
  //void seek(PVector target){
  //  PVector desired = PVector.sub(target, location);
  //  desired.normalize();
  //  desired.mult(maxspeed);

  //  PVector steer = PVector.sub(desired, velocity);
  //  steer.limit(maxforce);

  //  applyForce(steer);
  //}


  boolean isDead() {
    return this.lifespan<=0;
  }

  void setMaxSpeeds(float hmax, float vmax) {
    this.Hmaxspeed = hmax;
    this.Vmaxspeed = vmax;
  }

  private float sign(float x) {
    if (x >= 0) return 1.0;
    else return -1.0;
  }
}
