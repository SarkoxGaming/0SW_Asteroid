class Vaisseau extends GraphicObject {
  float angularVelocity = 0.0;
  float angularAcceleration = 0.0;
  
  float angle = 0.0;  
  float heading = 0.0;
  
  float w = 20;
  float h = 10;
  
  float mass = 1.0;
  
  float speedLimit = 5;
  boolean thrusting = false;
  
  PVector shootingVector = new PVector();
  PVector canonTip = new PVector();
  
  int nbEnnemieKilled = 0;
  
  Vie vie = new Vie(3);
  
  Vaisseau() {
    initValues();
  }
  
  Vaisseau(float x, float y) {
    initValues();
    location.x = x;
    location.y = y;
  }
  
  PVector getCanonTip() {
    return new PVector(cos(heading-HALF_PI)*size+location.x, sin(heading-HALF_PI)*size+location.y);
  }
  
  PVector getShootingVector() {
    float angle = heading - PI/2;
    
    shootingVector = new PVector (cos(angle), sin(angle));
    shootingVector.normalize();
    return shootingVector;
  }
  
  void initValues() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);
  }
  
  void checkEdges() {
    if (location.x < -size) location.x = width + size;
    if (location.y < -size) location.y = height + size;
    if (location.x > width + size) location.x = -size;
    if (location.y > height + size) location.y = -size;
  }
  
  void thrust(){
    
    float angle = heading - PI/2;
    
    PVector force = new PVector (cos(angle), sin(angle));
    force.mult(0.1);
    
    applyForce(force);
    
    thrusting = true;    
  }
  
  void update(float deltaTime) {
    checkEdges();
    
    velocity.add(acceleration);
    
    velocity.limit(speedLimit);
    
    location.add(velocity);
    
    acceleration.mult(0);
    
    angularVelocity += angularAcceleration;
    angle += angularVelocity;
    
    angularAcceleration = 0.0;
    
    Ennemie killedEnnemie = null;
    for (Ennemie ennemie : niveau.ennemies) {
      if (dist(ennemie.location.x,ennemie.location.y,location.x,location.y) < ennemie.r*5) {
        vie.remove(1);
        if (vie.getLife() == 0) {
          state = GameState.DEAD;
        }
        killedEnnemie = ennemie;
      }
    }
    if (killedEnnemie != null) {
      niveau.ennemies.remove(killedEnnemie);
    }
    
    for (Projectile p : bullets) {
      if (p.isVisible == true && dist(p.location.x,p.location.y,location.x,location.y) < 20) {
        vie.remove(1);
        if (vie.getLife() == 0) {
          state = GameState.DEAD;
        }
      }
    }
    
    
  }
  
  float size = 20;
  
  void display() {
    pushMatrix();
      translate (location.x, location.y);
      rotate (heading);
      
      fill(200);
      noStroke();
      
      beginShape(TRIANGLES);
        vertex(0, -size);
        vertex(size, size);
        vertex(-size, size);
      endShape();
      
      
      stroke(color(0,0,255));
      noFill();
      circle(0, size/3, size*3);
      
      noStroke();
      fill(200);
      if (thrusting) {
        fill(200, 0, 0);
      }
      rect(-size + (size/4), size, size / 2, size / 2);
      rect(size - ((size/4) + size/2), size, size / 2, size / 2);
      
    popMatrix();
  }
  
  void fire() {
     if (bullets.size() < maxBullets) {
      Projectile p = new Projectile();
      
      p.location = getCanonTip().copy();
      p.topSpeed = 10;
      p.velocity = getShootingVector().copy().mult(p.topSpeed);
     
      p.activate();
      
      p.file = getRandomPiou();
      p.file.play();
      
      bullets.add(p);
    } else {
      for ( Projectile p : bullets) {
        if (!p.isVisible) {
          p.location.x = getCanonTip().x;
          p.location.y = getCanonTip().y;
          p.velocity.x = getShootingVector().x;
          p.velocity.y = getShootingVector().y;
          p.velocity.mult(p.topSpeed);
          p.activate();
          p.file = getRandomPiou();
          p.file.play();
          break;
        }
      }
    }
    
    
  }
  
  void pivote(float angle) {
    heading += angle;
  }
  
  void noThrust() {
    thrusting = false;
  }
}
