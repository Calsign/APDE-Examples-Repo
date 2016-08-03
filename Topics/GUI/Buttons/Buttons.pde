/**
 * Buttons.
 * 
 * Click on one of the shapes to change 
 * the background color. This example 
 * demonstrates a class for buttons.
 */

color currentColor;

CircleButton circle1, circle2, circle3;
RectButton rect1, rect2;

boolean locked = false;

void setup() {
  size(200, 200);
  smooth();

  color baseColor = color(102);
  currentColor = baseColor;

  // Define and create circle button
  color buttonColor = color(204);
  color highlight = color(153);
  ellipseMode(CENTER);
  circle1 = new CircleButton(30, 100, 100, buttonColor, highlight);

  // Define and create circle button
  buttonColor = color(204);
  highlight = color(153); 
  circle2 = new CircleButton(130, 110, 24, buttonColor, highlight);

  // Define and create circle button
  buttonColor = color(153);
  highlight = color(102); 
  circle3 = new CircleButton(130, 140, 24, buttonColor, highlight);

  // Define and create rectangle button
  buttonColor = color(102);
  highlight = color(51); 
  rect1 = new RectButton(150, 20, 100, buttonColor, highlight);

  // Define and create rectangle button
  buttonColor = color(51);
  highlight = color(0); 
  rect2 = new RectButton(90, 20, 50, buttonColor, highlight);
}

void draw() {
  background(currentColor);
  stroke(255);
  update(mouseX, mouseY);
  circle1.display();
  circle2.display();
  circle3.display();
  rect1.display();
  rect2.display();
}

void update(int x, int y) {
  if(locked == false) {
    circle1.update();
    circle2.update();
    circle3.update();
    rect1.update();
    rect2.update();
  } else {
    locked = false;
  }
  
  if(mousePressed) {
    if(circle1.pressed()) {
      currentColor = circle1.baseColor;
    } else if(circle2.pressed()) {
      currentColor = circle2.baseColor;
    } else if(circle3.pressed()) {
      currentColor = circle3.baseColor;
    } else if(rect1.pressed()) {
      currentColor = rect1.baseColor;
    } else if(rect2.pressed()) {
      currentColor = rect2.baseColor;
    }
  }
}


class Button {
  int x, y;
  int size;
  color baseColor, highlightColor;
  color currentColor;
  boolean over = false;
  boolean pressed = false;   
  
  void update() {
    if(over()) {
      currentColor = highlightColor;
    } else {
      currentColor = baseColor;
    }
  }
  
  boolean pressed() {
    if(over) {
      locked = true;
      return true;
    } else {
      locked = false;
      return false;
    }    
  }
  
  boolean over() { 
    return true; 
  }
  
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width
          && mouseY >= y && mouseY <= y + height) {
      
      return true;
    } else {
      return false;
    }
  }
  
  boolean overCircle(int x, int y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < diameter / 2 ) {
      return true;
    } else {
      return false;
    }
  }
}

class CircleButton extends Button { 
  CircleButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    x = ix;
    y = iy;
    size = isize;
    baseColor = icolor;
    highlightColor = ihighlight;
    currentColor = baseColor;
  }
  
  boolean over() {
    if(overCircle(x, y, size)) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }
  
  void display() {
    stroke(255);
    fill(currentColor);
    ellipse(x, y, size, size);
  }
}

class RectButton extends Button {
  RectButton(int ix, int iy, int isize, color icolor, color ihighlight) {
    x = ix;
    y = iy;
    size = isize;
    baseColor = icolor;
    highlightColor = ihighlight;
    currentColor = baseColor;
  }
  
  boolean over() {
    if(overRect(x, y, size, size)) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }
  
  void display() {
    stroke(255);
    fill(currentColor);
    rect(x, y, size, size);
  }
}
