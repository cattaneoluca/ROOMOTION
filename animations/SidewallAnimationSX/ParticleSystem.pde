class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin, velocity, acceleration;
  float angle, speed, p1, p2, p3, p4;
  float HmaxSpeed = 0,VmaxSpeed=0;
  StateEmotion emotion;
  
  //float [] amp = new float[6];
  FloatList ap;
  float radius;
  float radiusHist;
  float brightness;
  int counter;
  
  
  //color c1, c2, c3, c4;
  //color [] c = {c1, c2, c3, c4};
  color colour;
  ParticleSystem(){
    this.emotion = new Neutral();
    this.particles = new ArrayList<Particle>();
    //this.origin=new PVector(width/2, height/2);
    this.angle = HALF_PI;
    float x = width/2 + cos(this.angle)*width/3;
    float y = height/2 - sin(this.angle)*height/3;
    this.origin=new PVector(x,y);
    this.speed=0.05;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    
    this.brightness = 255;
    this.colour = color(255, 255, 255);
    //grey
    //this.c1 = color(192, 192, 192);
    //red for angry
    /*this.c1 = color(180, 30, 0);
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
    this.p4=0;*/
    
    this.HmaxSpeed = 3.5;
    this.VmaxSpeed = 3.5;
    //for (int i=0; i<5; i++){
    //  this.amp[i] = 6.0;
    //}
    
    this.radius = 10.0;
    this.radiusHist = this.radius;
    this.ap = new FloatList();
    //this.ap.append(radius);
    this.counter = 0;
    
    //for (int i=0; i<5; i++){
    //  this.amp[i] = radius;
    //}
  }
  
  
  color getColor(){
    float seed = random(0,1);
    if(seed<this.p1) return new Angry().getColor();
    else if (seed<this.p1+this.p2) return new Happy().getColor();
    else if (seed<this.p1+this.p2+this.p3) return new Neutral().getColor();
    else return new Sad().getColor();
  }
  
  float getRadius(){
    float seed = random(0,1);
    float [] amp = ap.array();
    if(seed<amp[0]) return this.radius*(1+amp[0]*10);
    else if (seed<amp[0] + amp[1]) return this.radius*(1+amp[1]*5);
    else if (seed<amp[0] + amp[1] + amp[2]) return this.radius*(1+amp[2]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3]) return this.radius*(1+amp[3]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4]) return this.radius*(1+amp[4]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5]) return this.radius*(1+amp[5]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5] + amp[6]) return this.radius*(1+amp[6]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5] + amp[6] + amp[7]) return this.radius*(1+amp[7]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5] + amp[6] + amp[7] + amp[8]) return this.radius*(1+amp[8]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5] + amp[6] + amp[7] + amp[8] + amp[9]) return this.radius*(1+amp[9]*5);
    else if (seed<amp[0] + amp[1] + amp[2] + amp[3] + amp[4] + amp[5] + amp[6] + amp[7] + amp[8] + amp[9] + amp[10]) return this.radius*(1+amp[10]*5);
    else return this.radius*(1+amp[11]*5);
  }
  
  
  
  
  //void addParticle(){
  //  color c = this.colour;
    
  //  float threshold = 0.5;
  //  if(this.p1+this.p2+this.p3+this.p4 > threshold){
  //    c = this.getColor();
      
      
  //    //int index = int(random(amp.length));
  //    float [] amp = ap.array();
  //    //int index = int(random(amp.length));
  //    if (this.counter >= amp.length){
  //      this.counter = 0;
  //    }
  //    int index = this.counter;
  //    //radiusAmp = amp[index];

      
  //    if (this.counter <= 0){
  //      this.radiusHist = this.radius;
  //    }
  //    else{
  //      if(amp[index] > amp[index-1]){
  //        this.radiusHist -= 3;
  //      }
  //      else{
  //        this.radiusHist += 5;
  //      }
  //    }
      
  //    this.counter += 1;
     
  //    //print(radiusAmp);
  //  }
    
  //  if ((this.radiusHist < this.radius) || (this.radiusHist > 20) ){
  //    this.radiusHist = this.radius;
  //  }
    
  //  float radiusAmp = this.radiusHist;
  //  this.particles.add(new Particle(new PVector(0,random(0,height)), radiusAmp, brightness, c));   
  //}
  
  void addParticle(){
    color c = this.colour;
    float radiusAmp = this.radius;
    float threshold = 0.5;
    if(this.p1+this.p2+this.p3+this.p4 > threshold){
      c = this.getColor();
      radiusAmp = this.getRadius();
      //println("lol");
      //println(radiusAmp);
    }
    this.particles.add(new Particle(new PVector(width,random(0,height)), radiusAmp, 300, c,
        this.HmaxSpeed, this.VmaxSpeed));   
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
  
  void action(PVector wind){
    Particle p;
    for(int i=this.particles.size()-1; i>=0; i--){
      p=this.particles.get(i);
      p.applyForce(wind);
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
