/**
 * Collision (Pong).
 * 
 * Move the mouse up and down to move the paddle.
 */

// Global variables for the ball
float ballx;
float bally;
float ballDir = 1;
float ballSize = 15; // Radius
float dy = 0;        // Direction

// Global variables for the paddle
int paddleWidth = 10;
int paddleHeight = 60;

int distWall = 15;

void setup() {
  size(640, 360);
  
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noStroke();
  smooth();
  
  bally = height / 2;
  ballx = 1;
}

void draw() {
  background(51);
  
  ballx += ballDir * 1.0;
  bally += dy;
  if (ballx > width + ballSize) {
    ballx = -width / 2 - ballSize;
    bally = random(0, height);
    dy = 0;
  }
  
  // Constrain paddle to screen
  float paddley = constrain(mouseY, paddleHeight, height - paddleHeight);
  
  // Test to see if the ball is touching the paddle
  float py = width - distWall - paddleWidth - ballSize;
  if (ballx == py 
      && bally > paddley - paddleHeight - ballSize 
      && bally < paddley + paddleHeight + ballSize) {
	
    ballDir *= -1;
    if (mouseY != pmouseY) {
      dy = (mouseY - pmouseY) / 2.0;
      if(dy >  5) { dy =  5; }
      if(dy < -5) { dy = -5; }
    }
  }
  
  // If ball hits paddle or back wall, reverse direction
  if (ballx < ballSize && ballDir == -1) {
    ballDir *= -1;
  }
  
  // If the ball is touching top or bottom edge, reverse direction
  if (bally > height - ballSize) {
    dy = dy * -1;
  }
  if (bally < ballSize) {
    dy = dy * -1;
  }
  
  // Draw ball
  fill(255);
  ellipse(ballx, bally, ballSize, ballSize);
  
  // Draw the paddle
  fill(153);
  rect(width - distWall, paddley, paddleWidth, paddleHeight);
}
