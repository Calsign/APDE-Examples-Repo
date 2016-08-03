// Spark class
class Spark {
  PVector loc;
  PVector vel;
  PVector acc;
  
  float angle;
  
  int baseColor;
  
  Spark() {
    loc = new PVector(mouseX, mouseY);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    baseColor = (int) random(0, 360);
  }
  
  void update() {
    // Move in a random direction...
    angle += random(0, TWO_PI);
    // ...with a random magnitude
    float magni = random(0, 3);
    
    acc.x += cos(angle) * magni;
    acc.y += sin(angle) * magni;
    
    acc.limit(3);
    
    vel.add(acc);
    vel.limit(6);
    
    loc.add(vel);
    
    // Wrap around the screen
    if(loc.x > width)
      loc.x -= width;
    if(loc.x < 0)
      loc.x += width;
    if(loc.y > height)
      loc.y -= height;
    if(loc.y < 0)
      loc.y += height;
  }
  
  void display() {
    // Cycle through colors
    stroke((baseColor + millis() / 25.0) 
        % 360, 80, 80, 204);
    strokeWeight(15);
    
    point(loc.x, loc.y);
  }
}
