class Score {

  int score;

  Score() {
    this.score = 0;
  }
  
  Score(int score) {
    this.score = score;
  }
 
 
  public int getScore() {
    return score;
  }
 
  public void add(int point) {
    score += point;
  }
 
  public void remove(int point) {
    score -= point;
  }
 
}
