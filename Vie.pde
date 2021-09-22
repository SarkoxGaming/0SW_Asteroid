class Vie {

  int maximum;
  int minimum;
  int current = 0;
  
 
  Vie(int maximum) {
    this.maximum = maximum;
    this.current = maximum;
  }
 
  Vie(int minimum, int maximum) {
    this.minimum = minimum;
    this.maximum = maximum;
  }
 
 
  public int getLife() {
    return current;
  }
 
  public void add(int pv) {
    current += pv;
  }
 
  public void remove(int pv) {
    current -= pv;
  }
  
  @Override
  public String toString() {
      return String.format( "" +getLife());
  }
  
}
