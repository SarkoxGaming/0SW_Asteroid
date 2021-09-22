class Projectile extends GraphicObject {
  boolean isVisible = false;
  
  SoundFile file;
  
  Projectile () {
    super();
  }
  
  void activate() {
    isVisible = true;
  }
  
  void setDirection(PVector v) {
    velocity = v;
  }
  
  
  void update(float deltaTime) {
    
    if (!isVisible) return;
    
    super.update();
    
    hitEnnemie();
    
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      isVisible = false;
    }
  }
  
  void hitEnnemie() {
    Ennemie killedEnnemie = null;
    for (Ennemie ennemie : niveau.ennemies) {
      if (dist(ennemie.location.x,ennemie.location.y,location.x,location.y) < ennemie.r*5) {
        score.add(1);
        if (score.getScore() % 100 == 0) {
          v.vie.add(1);
        }
        killedEnnemie = ennemie;
      }
    }
    if (killedEnnemie != null) {
      niveau.ennemies.remove(killedEnnemie);
    }
    
    if (niveau.ennemies.size() == 0) {
      niveau.addNiveau(1);
    }
    
  }
  
  void display() {
    
    if (isVisible) {
      pushMatrix();
        fill(255);
        translate (location.x, location.y);
        
        ellipse (0, 0, 3, 3);
      popMatrix();
    }
  }
}
