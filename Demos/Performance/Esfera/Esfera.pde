/**
 * Esfera (Sphere)
 * by David Pena.
 * 
 * Random, even distribution over the surface of a sphere.
 * 
 * Note: Translated from Spanish by CalsignLabs
 */

int count = 1600;
Hair[] list;
float radius = 200;
float rx = 0;
float ry = 0;

void setup() {
  size(displayWidth, displayHeight, P3D);
  noSmooth();
  frameRate(120);
  radius = height / 3.5;
  
  list = new Hair[count];
  for (int i = 0; i < count; i ++) {
    list[i] = new Hair();
  }
  
  noiseDetail(3);
}

void draw() {
  background(0);
  translate(width/2,height/2);
  
  float rxp = ((mouseX - (width / 2)) * 0.005);
  float ryp = ((mouseY - (height / 2)) * 0.005);
  rx = (rx * 0.9) + (rxp * 0.1);
  ry = (ry * 0.9) + (ryp * 0.1);
  rotateY(rx);
  rotateX(ry);
  fill(0);
  noStroke();
  sphere(radius);
  
  for (int i = 0; i < count; i ++){
    list[i].display();
  }
  if (frameCount % 10 == 0) {
    println(frameRate);
  }  
}

class Hair {
  float z = random(-radius, radius);
  float phi = random(TWO_PI);
  float length = random(1.15, 1.2);
  float theta = asin(z / radius);
  
  void display() {
    float off = (noise(millis() * 0.0005, sin(phi)) - 0.5) * 0.3;
    float offb = (noise(millis() * 0.0007, sin(z) * 0.01) - 0.5) * 0.3;
    
    float thetaff = theta + off;
    float phff = phi + offb;
    float x = radius * cos(theta) * cos(phi);
    float y = radius * cos(theta) * sin(phi);
    float z = radius * sin(theta);
    
    float xo = radius * cos(thetaff) * cos(phff);
    float yo = radius * cos(thetaff) * sin(phff);
    float zo = radius * sin(thetaff);
    
    float xb = xo * length;
    float yb = yo * length;
    float zb = zo * length;
    
    strokeWeight(1);
    beginShape(LINES);
    stroke(0);
    vertex(x, y, z);
    stroke(200, 150);
    vertex(xb, yb, zb);
    endShape();
  }
}
