class Ennemie extends GraphicObject {
  float topSpeed = 1;
  float topSteer = 0.05;
  
  float mass = 1;
  
  float theta = 0;
  float r = 5; // Rayon du boid
  
  float radiusSeparation = 10 * r;
  float radiusAlignment = 20 * r;
  float radiusCohesion = 30 * r;

  float weightSeparation = 2;
  float weightAlignment = 1;
  float weightCohesion = 1;
  
  PVector steer;
  PVector sumAlignment;
  PVector sumCohesion;

  PVector zeroVector = new PVector(0, 0);

  
  Ennemie () {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  Ennemie (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
  }
  
  void checkEdges() {
    if (location.x < -20) {
      location.x = width+20 - r;
    } else if (location.x + r> width+20) {
      location.x = -20;
    }
    
    if (location.y < -20) {
      location.y = height+20 - r;
    } else if (location.y + r> height+20) {
      location.y = -20;
    }
  }
  
  void flock (ArrayList<Ennemie> boids) {
    PVector separation = separate(boids);
    PVector alignment = align(boids);
    PVector cohesion = cohesion(boids);
    
    separation.mult(weightSeparation);
    alignment.mult(weightSeparation);
    cohesion.mult(weightCohesion);

    applyForce(separation);
    applyForce(alignment);
    applyForce(cohesion);
  }
  
  
  void update(float deltaTime) {
    checkEdges();

    velocity.add (acceleration);
    velocity.limit(topSpeed);

    theta = velocity.heading() + radians(90);

    location.add (velocity);

    acceleration.mult (0);      
  }
  
  void display() {
    noStroke();
    fill (fillColor);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate (theta);
    
    beginShape(TRIANGLES);
      vertex(0, -r * 2);
      vertex(-r, r * 2);
      vertex(r, r * 2);
    
    endShape();
    
    stroke(color(0,0,255));
    noFill();
    circle(0, 0, r*5);
    
    popMatrix();
  }
  
  PVector separate (ArrayList<Ennemie> boids) {
    if (steer == null) {
      steer = new PVector(0, 0, 0);
    }
    else {
      steer.setMag(0);
    }
    
    int count = 0;
    
    for (Ennemie other : boids) {
      float d = PVector.dist(location, other.location);
      
      if (d > 0 && d < radiusSeparation) {
        PVector diff = PVector.sub(location, other.location);
        
        diff.normalize();
        diff.div(d);
        
        steer.add(diff);
        
        count++;
      }
    }
    
    if (count > 0) {
      steer.div(count);
    }
    
    if (steer.mag() > 0) {
      steer.setMag(topSpeed);
      steer.sub(velocity);
      steer.limit(topSteer);
    }
    
    return steer;
  }

  PVector align (ArrayList<Ennemie> boids) {

    if (sumAlignment == null) {
      sumAlignment = new PVector();      
    } else {
      sumAlignment.mult(0);
    }

    int count = 0;

    for (Ennemie other : boids) {
      float d = PVector.dist(this.location, other.location);

      if (d > 0 && d < radiusAlignment) {
        sumAlignment.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      sumAlignment.div((float)count);
      sumAlignment.setMag(topSpeed);

      PVector steer = PVector.sub(sumAlignment, this.velocity);
      steer.limit(topSteer);

      return steer;
    } else {
      return zeroVector;
    }
  }

   // Méthode qui calcule et applique une force de braquage vers une cible
  // STEER = CIBLE moins VITESSE
  PVector seek (PVector target) {
    // Vecteur différentiel vers la cible
    PVector desired = PVector.sub (target, this.location);
    
    // VITESSE MAXIMALE VERS LA CIBLE
    desired.setMag(topSpeed);
    
    // Braquage
    PVector steer = PVector.sub (desired, velocity);
    steer.limit(topSteer);
    
    return steer;    
  }

  PVector cohesion (ArrayList<Ennemie> boids) {
    if (sumCohesion == null) {
      sumCohesion = new PVector();      
    } else {
      sumCohesion.mult(0);
    }

    int count = 0;

    for (Ennemie other : boids) {
      float d = PVector.dist(location, other.location);

      if (d > 0 && d < radiusCohesion) {
        sumCohesion.add(other.location);
        count++;
      }
    }

    if (count > 0) {
      sumCohesion.div(count);

      return seek(sumCohesion);
    } else {
      return zeroVector;
    }
    
  }
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);    
  }
}
