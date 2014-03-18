
// power controls how steep the spike is
// speed controls how long it takes to spike
float base, speed, power;

int mode = 0;
int modes = 5;

boolean isOn;
float duration;
int count;
Curve curve;

// To draw the curve
float x, y;

int diameter;

void setup() {
  size(800, 400);
  reset();
}

void draw() {
  
  if (isOn) fill(255, 0, 0);
  else fill(255);
  ellipse(width/2, height/2, diameter, diameter);

  if (count >= duration) {
    duration = calc();
    diameter++;
    isOn = !isOn;
    count = 0;
    display();
  }


  count++;
}

void display() {
  x++;
  y = height-duration;
  noStroke(); 
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);
}

float calc() {
  return map(curve.run(), 0, height, 0, 360);
}

void reset() {
  background(0);
  base = 0;
  diameter = 0;
  x = 0;

  switch(mode) {
  case 0:
    curve = new Linear((float)height/(float)width);  
    break;    
  case 1:
    speed = 0.005;
    power = 20;
    curve = new Exponential(base, power, speed);
    break;
  case 2:
    power = 0;
    speed = 1;
    curve = new Logarithmic(base, power, speed);
    break;
  case 3:
    base = -7.5;
    speed = 0.025;
    curve = new Sigmoid(base, speed);
    break;
  case 4:
    base = -7.5;
    curve = new Bounce();
    break;
  }  

  println("MODE: " + curve.getClass());
}


void keyPressed() {

  switch(keyCode) {
  case RIGHT:
    mode++;
    break;
  case LEFT:
    mode--;
    break;
  }

  if (mode >= modes || mode < 0) {
    mode = (modes + abs(mode))%modes;
  }
  reset();
}

