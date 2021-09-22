class Niveau {

  int current;
  int nbEnnemie;
  ArrayList<Ennemie> ennemies;
  
  Niveau() {
    this.current = 0;
    this.nbEnnemie = 20;
    ennemies = new ArrayList<Ennemie>();
  
    summonEnnemie();
  }

  public int getCurrentNiveau() {
    return current;
  }
  
  public int getMaxEnnemie() {
    return nbEnnemie;
  }
 
  public void addNiveau(int niveau) {
    current += niveau;
    nbEnnemie += (niveau * 5);
    summonEnnemie();
  }
  
  public void verifEnnemieDelta() {
    if (ennemies.size() == 0) {
      println("done");
    }
    
  }
  
  public void summonEnnemie() {
    
    for (int i = 0; i < nbEnnemie; i++) {
      PVector location;
      do {
        location = new PVector(random(0, width), random(0, height));
      } while(dist(location.x, location.y, v.location.x, v.location.y) < v.size*10);
      Ennemie ennemie = new Ennemie(location, new PVector(random (-2, 2), random(-2, 2)));
      ennemie.fillColor = color(0,255,0);
      ennemies.add(ennemie);
    }
  }
 
}
