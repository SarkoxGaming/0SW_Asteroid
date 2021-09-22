public class DisplayText extends GraphicObject {
  
  String text;
  float x,y,size = -1;
  int textColor = -1;
  boolean isCenter,isLeft = false;
  
  DisplayText() {
  }
  
  DisplayText setText(String text) {
    this.text = text;
    return this;
  }
  
  DisplayText setPosition(float x, float y) {
    this.x = x;
    this.y = y;
    return this;
  }
  
  DisplayText setSize(float size) {
    this.size = size;
    return this;
  }
  
  DisplayText setColor(int textColor) {
    this.textColor = textColor;
    return this;
  }
  
  void display() {
    if (textColor != -1) fill(textColor);
    if (size != -1) textSize(size);
    if (isCenter) textAlign(CENTER);
    if (isLeft) textAlign(LEFT);
    text(text, x, y);
  }
  
  DisplayText setCenter() {
    isCenter = true;
    return this;
  }
  
  DisplayText setLeft() {
    isLeft = true;
    return this;
  }


}
