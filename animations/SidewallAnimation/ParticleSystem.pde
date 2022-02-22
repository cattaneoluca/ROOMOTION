class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin, velocity, acceleration;
  float angle, speed, p1, p2, p3, p4;
  color c1, c2, c3, c4;
  color [] c = {c1, c2, c3, c4};
  color colour;
  ParticleSystem(){
    this.particles = new ArrayList<Particle>();
    //this.origin=new PVector(width/2, height/2);
    this.angle = HALF_PI;
    float x = width/2 + cos(this.angle)*width/3;
    float y = height/2 - sin(this.angle)*height/3;
    this.origin=new PVector(x,y);
    this.speed=0.05;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.colour = color(255, 255, 255);
    //grey
    //this.c1 = color(192, 192, 192);
    //red for angry
    this.c1 = color(180, 30, 0);
    //yellow for happy
    this.c2 = color(255, 204, 0);
    //cyan for neutral
    this.c3 = color(0,200,200);
    //blue for sad
    this.c4 = color(0, 75, 150);
    this.c[0] = c1;
    this.c[1] = c2;
    this.c[2] = c3;
    this.c[3] = c4;
    this.p1=0;
    this.p2=0;
    this.p3=0;
    this.p4=0;
  }
  
  
  color getColor(){
    float seed = random(0,1);
    if(seed<this.p1) return this.c[0];
    else if (seed<this.p1+this.p2) return this.c[1];
    else if (seed<this.p1+this.p2+this.p3) return this.c[2];
    else return this.c[3];
  }
  
  void addParticle(){
    color c = this.colour;
    float threshold = 0.5;
    if(this.p1+this.p2+this.p3+this.p4 > threshold) 
                                    c = this.getColor();
    
    this.particles.add(new Particle(new PVector(0,random(0,height)), 4, 200, c));   
  }
  
  void update(){    
    this.velocity.add(this.acceleration);
    this.origin.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void applyMove(PVector force){    
    this.acceleration.add(force);
  }
  
  void circularMotion(){
    float x = width/2 + cos(this.angle)*width/2.5;
    float y = height/2 - sin(this.angle)*height/3;
    this.origin = new PVector(x,y);
    
    this.angle += this.speed;
  }
  
  void checkEdges() {

    if (origin.x > width) {
      origin.x = 0;
    } 
    else if (origin.x < 0) {
      origin.x = width;
    }

    if (origin.y > height) {
      origin.y = 0;
    } 
    else if (origin.y < 0) {
      origin.y = height;
    }
  }
  
  void action(PVector steering){
    Particle p;
    for(int i=this.particles.size()-1; i>=0; i--){
      p=this.particles.get(i);

      p.action();
      p.lifespan-=0.5;
      if(p.isDead()){
         particles.remove(i);
         this.addParticle();
      }
    }
    this.checkEdges();
  }

}
