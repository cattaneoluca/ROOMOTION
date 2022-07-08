class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin, velocity, acceleration;
  float angle, speed, p1, p2, p3, p4;
  color [] c = new color[4];
  color colour;
  float maxspeed;
  AudioStream audio;

  ParticleSystem(EmoSphereNew app) {
    this.particles = new ArrayList<Particle>();
    //this.origin=new PVector(width/2, height/2);
    this.angle = HALF_PI;
    float x = width/2 + cos(this.angle)*width/3;
    float y = height/2 - sin(this.angle)*height/3;
    this.origin=new PVector(x, y);
    this.speed=0.05;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.colour = color(255, 255, 255);
    this.c[0] = color(255, 86, 7); // angry
    this.c[1] = color(255, 193, 0); // happy
    this.c[2] = color(60, 179, 113); // neutral
    this.c[3] = color(0, 0, 205); // sad
    this.p1=0;
    this.p2=0;
    this.p3=0;
    this.p4=0;
    // testing ***
    this.maxspeed = 4.5;
    this.audio = new AudioStream(app);
  }

  color getColor() {
    float seed = random(0, 1);
    if (seed<this.p1) return this.c[0];
    else if (seed<this.p1+this.p2) return this.c[1];
    else if (seed<this.p1+this.p2+this.p3) return this.c[2];
    else return this.c[3];
  }

  void addParticle() {
    color c = this.colour;
    float threshold = 0.5;
    if (this.p1+this.p2+this.p3+this.p4 > threshold)
      c = this.getColor();

    this.particles.add(new Particle(this.origin, 3.5, random(0, 200), c));
  }

  void update() {
    this.velocity.add(this.acceleration);
    this.origin.add(this.velocity);
    this.acceleration.mult(0);
  }

  void applyMove(PVector force) {
    this.acceleration.add(force);
  }

  void circularMotion() {
    float x = width/2 + cos(this.angle)*width/2.5;
    float y = height/2 - sin(this.angle)*height/3;
    this.origin = new PVector(x, y);

    this.angle += this.speed;
  }

  void checkEdges() {

    if (origin.x > width) {
      origin.x = 0;
    } else if (origin.x < 0) {
      origin.x = width;
    }

    if (origin.y > height) {
      origin.y = 0;
    } else if (origin.y < 0) {
      origin.y = height;
    }
  }

  void action(PVector steering) {
    // println(this.maxspeed);

    Particle p;
    float energy = this.audio.getEnergy();
    for (int i=this.particles.size()-1; i>=0; i--) {
      p=this.particles.get(i);
      p.SetMaxSpeed(maxspeed);
      p.seek(steering);
      // p.applyForce(new PVector(random(-0.1, 0.1), random(0.1,0.3)));

      p.action(energy);
      p.lifespan-=0.5;
      if (p.isDead()) {
        particles.remove(i);
        this.addParticle();
      }
    }
    // this.applyMove(new PVector(random(-0.1, 0.1), random(-0.1,0.1)));
    // this.update();
    this.circularMotion();
    this.checkEdges();
  }

  public void SetMaxSpeed(float maxspeed) {
    this.maxspeed = maxspeed;
  }
}
