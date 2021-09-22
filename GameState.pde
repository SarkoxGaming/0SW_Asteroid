public enum GameState {
  MENU,
  STARTUP,
  GAME,
  NEXTLVL,
  DEAD;
}


void Menu() {
  
  background(0);
  
  v = new Vaisseau(width / 4, height / 2);
  
  new DisplayText().setText("Bienvenue au jeu Asteroid!").setPosition(width/2, height/3).setSize(40).setColor(255).setCenter().display();
  new DisplayText().setText("Par Mathieu Savard").setPosition(width/2, height/3 + 40).setSize(30).setColor(255).setCenter().display();
  new DisplayText().setText("Appuyer sur Espace pour commencer").setPosition(width/2, height/2 + 140).setSize(20).setColor(255).setCenter().display();
  v.display();
  
  if (keyPressed)
    if (key == ' ')
      state = GameState.STARTUP;
}

void Startup() {
   
  v = new Vaisseau();
  v.location.x = width / 2;
  v.location.y = height / 2;
  bullets = new ArrayList<Projectile>();
  
  niveau = new Niveau();
  score = new Score();
  
  state = GameState.GAME;
}

void Game(int delta) {
  
  //----------------- update -----------------
  if (keyPressed) {
    switch (key) {
      case 'w':
        v.fire();
        break;
      case ' ':
        v.thrust();
        break;
      case 'a':
        v.pivote(-.05);
        break;
      case 'd':
        v.pivote(.05);
        break;
    }
  }
  
  for ( Projectile p : bullets) {
    p.update(deltaTime);
  }
  
  v.update(delta);
  
  for (Ennemie ennemie : niveau.ennemies) {
    ennemie.flock(niveau.ennemies);
    ennemie.update(delta);
  }
  
  //----------------- display -----------------
  background(0);
 
  
  for (Ennemie ennemie : niveau.ennemies) {
    ennemie.display();
  }
  
  for ( Projectile p : bullets) {
    p.display();
  }

  v.display();
  
  //----------------- HUD -----------------
  new DisplayText().setText("Vie: " + v.vie.getLife()).setPosition(20,30).setSize(20).setColor(255).setLeft().display();
  new DisplayText().setText("Niveau: " + (niveau.getCurrentNiveau()+1)).setPosition(20,60).setSize(20).setColor(255).setLeft().display();
  new DisplayText().setText("Score: " + score.getScore()).setPosition(20,90).setSize(20).setColor(255).setLeft().display();
  new DisplayText().setText("Ennemie restant: " + niveau.ennemies.size()).setPosition(20,120).setSize(20).setColor(255).setLeft().display();
}

void NextLVL() {
  
}

void Dead() {
  
  background(0);
  new DisplayText().setText("Tu es").setPosition(width/2, height/2-80).setSize(40).setColor(color(255,0,0)).setCenter().display();
  new DisplayText().setText("Mort").setPosition(width/2, height/2).setSize(100).setColor(color(255,0,0)).setCenter().display();
  new DisplayText().setText("Score: " + score.getScore()).setPosition(width/2, height/2+30).setSize(20).setColor(255).setCenter().display();
  new DisplayText().setText("Appuyer sur 'r' pour recommencer").setPosition(width/2, height/2 + 200).setSize(20).setColor(255).setCenter().display();
  
}
