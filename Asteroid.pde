import processing.sound.*;

SoundFile file;

int currentTime;
int previousTime;
int deltaTime;
ArrayList<Projectile> bullets;
int maxBullets = 6;
Vaisseau v;
Niveau niveau;
Score score;

GameState state;

ArrayList<SoundFile> pious = new ArrayList<SoundFile>();

void initPiou() {
  for (int i = 1; i<15; i++) {
    pious.add(new SoundFile(this, "piou"+i+".mp3"));
  }
}

void setup () {
  size (1000, 600);
  currentTime = millis();
  previousTime = millis();
  
  initPiou();
  
  state = GameState.MENU;
} 

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  if (state == GameState.MENU)
    Menu();
  if (state == GameState.STARTUP)
    Startup();
  if (state == GameState.GAME)
    Game(deltaTime);
  if (state == GameState.DEAD) 
    Dead();
}

SoundFile getRandomPiou() {
  return pious.get(int(random(random(0,pious.size()))));
}

void keyReleased() {
  if (state == GameState.GAME) {
    switch (key) {
      case ' ':
        v.noThrust();
        break;
    }  
  }
}

void keyPressed() {
  if (state != GameState.MENU) {
    if (key == 'r') {
      state = GameState.MENU;
    }
  }
}
