ArrayList<Ball> balls;

boolean run = true;

final int maxBalls = 40;

int cursorSize = 100;
int cursorStroke = 3;

boolean tween = true;

int pressedButton = -1;

void setup() {
  size(1580, 720);
  background(255);
  balls = new ArrayList<Ball>();
  Ball start = new Ball(randomSize(), 5, 5, 0, 0, randomColor(), randomColor(), randomStroke());
  balls.add(start);
  
  //Ball test = new Ball(randomSize(), -5, -5, width/2, height/2, randomColor(), randomColor(), randomStroke());
  //balls.add(test);
}

public void keyPressed() {
  //println("Key Pressed " + keyCode);
  if(key == CODED) {
    if(keyCode == UP&& (pressedButton == -1 || pressedButton == 0)) {
      pressedButton = 0;
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).speedY();
        balls.get(i).speedX();
      }
    } else if(keyCode == DOWN && (pressedButton == -1 || pressedButton == 1)) {
      pressedButton = 1;
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).decSpeedY();
        balls.get(i).decSpeedX();
      }
    } else if(keyCode == LEFT && (pressedButton == -1 || pressedButton == 3)) {
      pressedButton = 3;
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).decSize();
      }
    } else if(keyCode == RIGHT && (pressedButton == -1 || pressedButton == 2)) {
      pressedButton = 2;
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).incSize();
      }
    }
  } else if(keyCode == 32 && (pressedButton == -1 || pressedButton == 4)) {
    pressedButton = 4;
    run = !run;
  } else if(keyCode == 45) {
    cursorSize -= 5;
  } else if(keyCode == 61) {
    cursorSize += 5;
  }
}

public void keyReleased() {
  if(key == CODED) {
    if(keyCode == UP && pressedButton == 0) {
      pressedButton = -1;
    } else if(keyCode == DOWN && pressedButton == 1) {
      pressedButton = -1;
    } else if(keyCode == LEFT && pressedButton == 3) {
      pressedButton = -1;
    } else if(keyCode == RIGHT && pressedButton == 2) {
      pressedButton = -1;
    }
  } else if(keyCode == 32 && pressedButton == 4) {
    pressedButton = -1;
  }
}

public int randomColor() {
  return color((int) (Math.random() * 256), (int) (Math.random() * 256), (int) (Math.random() * 256));
}

public Double dist(int x1, int y1, int x2, int y2) {
  return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
}

void draw() {
  background(255);
  collisions();
  for(int i = 0; i < balls.size(); i ++) {
    Ball b = balls.get(i);
    fill(b.getColor());
    stroke(b.getStroke());
    strokeWeight(b.getStrokeSize());
    translate(b.xLoc, b.yLoc);
    rotate((float) Math.atan(b.ySpeed / b.xSpeed));
    ellipse(0, 0, b.getSize() - b.tween, b.getSize() - b.tween/2);
    rotate((float) -Math.atan(b.ySpeed / b.xSpeed));
    translate(-b.xLoc, -b.yLoc);
    if(run) {
      b.increment();
    }
  }  
  fill(255);
  stroke(0);
  strokeWeight(cursorStroke);
  ellipse(mouseX, mouseY, cursorSize, cursorSize);
  strokeWeight(5);
  rect(1280, -2.5, 302.5, 722.5);
  // Midway point of rect is at 1430
  int size = 30;
  // Padding = (720 - num * 2*size) / num + 1 (top padding)
  int padding = (height - (5 * 2 * size)) / (5 + 1);
  textSize(20);
  fill(0);
  text("KEYS:", 1430 - (textWidth("KEYS:") / 2.0), 20);
  fill(255);
  for(int i = 0; i < 5; i ++) {
    if(pressedButton == i) {
      fill(211, 255, 211);
    } else {
      fill(255);
    }
    rect(1430 - size, padding + (i * (padding + (2 * size))), 2 * size, 2 * size, size/2);
    String text = "";
    if(i == 0) {
      text = "Increase System Energy";
      fill(0);
      stroke(0);
      rect(1428, 95, 4, 20);
      triangle(1430, 85, 1437, 95, 1423, 95);
    } else if(i == 1) {
      text = "Decrease System Energy";
      fill(0);
      stroke(0);
      rect(1428, 214, 4, 20);
      triangle(1430, 244, 1437, 234, 1423, 234);
    } else if(i == 2) {
      text = "Increase System Mass";
      fill(0);
      stroke(0);
      rect(1413, 357, 20, 4);
      triangle(1433, 366, 1433, 352, 1443, 359);
    } else if(i == 3) {
      text = "Decrease System Mass";
      fill(0);
      stroke(0);
      rect(1425, 487, 20, 4);
      triangle(1425, 496, 1425, 482, 1415, 489);
    } else if(i == 4) {
      fill(255);
      stroke(0);
      strokeWeight(2);
      rect(1416, 615, 30, 10);
      text = "Pause System";
    }
    fill(0);
    text(text, 1430 - (textWidth(text) / 2.0), padding / 1.2 + (i * (padding + (2 * size))));
    text("Tween:", 1370, 700);
    if(tween) {
      fill(211, 255, 211);
    } else {
      fill(255);
    }
    rect(1450, 677.5, 30, 30);
  }
}

public void collisions() {
  Ball cursor = new Ball(cursorSize * 2, 0, 0, mouseX, mouseY, 255, 0, cursorStroke);
  for(int i = 0; i < balls.size(); i++) {
    Ball ball1 = balls.get(i);
    if(dist(mouseX, mouseY, ball1.xLoc, ball1.yLoc) <= ball1.diameter / 2.0 + cursorSize / 2.0 + cursorStroke + ball1.strokeSize && willCollide(ball1, cursor)) {
      cursor.xSpeed = -ball1.xSpeed;
      cursor.ySpeed = -ball1.ySpeed;
      collide3(ball1, cursor, true);
    }
    for(int j = i + 1; j < balls.size(); j++) {
      Ball ball2 = balls.get(j);
      if(dist(ball1.getX(), ball1.getY(), ball2.getX(), ball2.getY()) <= ball1.getSize() / 2.0 + ball2.getSize() / 2.0 + ball1.strokeSize + ball2.strokeSize - ball1.tween - ball2.tween && willCollide(ball1, ball2)) {
        //collide(ball1, ball2);
        //collide2(ball1, ball2);
        collide3(ball1, ball2, false);
        //println("Ball collision");
      } else {
        
      }
    }
  }
}

public boolean willCollide(Ball b1, Ball b2) {
  if((b1.xSpeed != 0 && Math.signum(b1.xSpeed) == Math.signum(b2.xLoc - b1.xLoc)) 
  || (b1.ySpeed != 0 && Math.signum(b1.ySpeed) == Math.signum(b2.yLoc - b1.yLoc))
  || (b2.xSpeed != 0 && Math.signum(b2.xSpeed) == Math.signum(b1.xLoc - b2.xLoc))
  || (b2.ySpeed != 0 && Math.signum(b2.ySpeed) == Math.signum(b1.yLoc - b2.yLoc))) {
    return true;
  }
  return false;
}

public void collide3(Ball b1, Ball b2, boolean solid) {
  // With Ball1 the center, angle of distortion from normal X acis to perpendicular contact
  double xDiff = b2.xLoc - b1.xLoc;
  double yDiff = b2.yLoc - b1.yLoc;
  
  //println(xDiff + " " + yDiff);
  //println(Math.toDegrees(Math.atan(yDiff/xDiff)));
  //println(Math.toDegrees(Math.atan(-xDiff/yDiff)));
  
  double angleDist = 0;
  if(xDiff == 0) {
    angleDist = 90;
  } else {
    angleDist = Math.abs(Math.toDegrees(Math.atan(yDiff/xDiff)));
  }
  //println("hit angle " + angleDist);
  //println(90 - angleDist);
  //println(Math.abs(Math.toDegrees(Math.atan(yDiff/xDiff))));
  //println(Math.abs(Math.toDegrees(Math.atan(-xDiff/yDiff))));

  double angleSpeed = 0;
  if(b1.xSpeed == 0) {
    angleSpeed = 90;
  } else {
    angleSpeed = Math.abs(Math.toDegrees(Math.atan(b1.ySpeed/b1.xSpeed)));
  }
  //println(angleDist + " " + angleSpeed + " " + xDiff + "|" + yDiff + " " + b1.xSpeed + "|" + b1.ySpeed);
  
  double finalAngle = 0;
  
  if(Math.signum(yDiff) != Math.signum(b1.ySpeed)) {
    finalAngle = Math.abs(angleDist + angleSpeed);
  } else {
    finalAngle = angleDist - angleSpeed;
  }
  
  //println(finalAngle);
  double FORCEDIFFX = b1.xSpeed;
  if(Math.signum(b1.xSpeed) == Math.signum(b2.xSpeed)) {
    FORCEDIFFX -= b2.xSpeed;
  }
  
  double FORCEDIFFY = b1.ySpeed;
  if(Math.signum(b1.ySpeed) == Math.signum(b2.ySpeed)) {
    FORCEDIFFX -= b2.ySpeed;
  }
  
  double hyp = Math.sqrt(Math.pow(FORCEDIFFX,2) + Math.pow(FORCEDIFFY,2));
  double FORCEONB2BYB1 = Math.cos(Math.toRadians(finalAngle)) * hyp;
  double FORCEONB1BYB1 = Math.sin(Math.toRadians(finalAngle)) * hyp;
  
  //println(FORCEONB2BYB1 + " " + FORCEONB1BYB1);
  //println("hit angle " + angleDist);
  //println(90 - angleDist);
  
  double B2XFEEL1 = Math.cos(Math.toRadians(angleDist)) * FORCEONB2BYB1;
  double B2YFEEL1 = Math.sin(Math.toRadians(angleDist)) * FORCEONB2BYB1;
  
  //println("SIN OF 90 " + Math.sin(Math.toRadians(angleDist)) + " " + FORCEONB2BYB1 + " ");
  
  double B1XFEEL1 = Math.cos(Math.toRadians(90 + angleDist)) * FORCEONB1BYB1;
  double B1YFEEL1 = Math.sin(Math.toRadians(90 + angleDist)) * FORCEONB1BYB1;
  
  //println("FEELING");  
  //println(B2XFEEL1 + " | " + B2YFEEL1);
  //println(B1XFEEL1 + " | " + B1YFEEL1);
  
  FORCEDIFFX = b2.xSpeed;
  if(Math.signum(b1.xSpeed) == Math.signum(b2.xSpeed)) {
    FORCEDIFFX -= b1.xSpeed;
  }
  
  FORCEDIFFY = b2.ySpeed;
  if(Math.signum(b1.ySpeed) == Math.signum(b2.ySpeed)) {
    FORCEDIFFX -= b1.ySpeed;
  }
  
  hyp = Math.sqrt(Math.pow(FORCEDIFFX,2) + Math.pow(FORCEDIFFY,2));
  double FORCEONB2BYB2 = Math.sin(Math.toRadians(finalAngle)) * hyp;
  double FORCEONB1BYB2 = Math.cos(Math.toRadians(finalAngle)) * hyp;
  
  //println(FORCEONB2BYB2 + " " + FORCEONB1BYB2);
  
  double B1XFEEL2 = Math.cos(Math.toRadians(angleDist)) * FORCEONB1BYB2;
  double B1YFEEL2 = Math.sin(Math.toRadians(angleDist)) * FORCEONB1BYB2;
  
  //println("SIN OF 90 " + Math.sin(Math.toRadians(angleDist)) + " " + FORCEONB2BYB2 + " ");
  
  double B2XFEEL2 = Math.cos(Math.toRadians(90 + angleDist)) * FORCEONB2BYB2;
  double B2YFEEL2 = Math.sin(Math.toRadians(90 + angleDist)) * FORCEONB2BYB2;
  
  if(b1.yLoc > b2.yLoc) {
    // If ball 1 contacts ball 2 from below, ball 2 must be pushed up, and ball 1 down
    B2YFEEL1 = -Math.abs(B2YFEEL1);
    B1YFEEL2 = Math.abs(B1YFEEL2);
  } else {
    // Ball 1 makes contact from above, pushing 1 back up and 2 down
    B2YFEEL1 = Math.abs(B2YFEEL1);
    B1YFEEL2 = -Math.abs(B1YFEEL2);
  }
  
  if(b1.xLoc > b2.xLoc) {
    // If ball 1 contacts ball 2 from the right, ball 2 must be pushed left, and ball 1 right
    B2XFEEL1 = -Math.abs(B2XFEEL1);
    B1XFEEL2 = Math.abs(B1XFEEL2);
  } else {
    // Ball 1 makes contact from left, pushing 1 back left and 2 right
    B2XFEEL1 = Math.abs(B2XFEEL1);
    B1XFEEL2 = -Math.abs(B1XFEEL2);
  }
  
  B1XFEEL1 = Math.signum(b1.xSpeed) * Math.abs(B1XFEEL1);
  B2XFEEL2 = Math.signum(b2.xSpeed) * Math.abs(B2XFEEL2);
  B1YFEEL1 = Math.signum(b1.ySpeed) * Math.abs(B1YFEEL1);
  B2YFEEL2 = Math.signum(b2.ySpeed) * Math.abs(B2YFEEL2);
  
  //println("FEELING ALL 1");
  //println(B2XFEEL1 + " | " + B2YFEEL1);
  //println(B1XFEEL1 + " | " + B1YFEEL1);
  //println("FEELING 2");
  //println(B2XFEEL2 + " | " + B2YFEEL2);
  //println(B1XFEEL2 + " | " + B1YFEEL2);
  
  if(solid) {
    B2XFEEL1 = 0;
    B2XFEEL2 = 0;
    B2YFEEL1 = 0;
    B2YFEEL2 = 0;
    b2.xSpeed = 0;
    b2.ySpeed = 0;
  }
 
  double systemTotal = Math.abs(b1.xSpeed) + Math.abs(b2.xSpeed) + Math.abs(b1.ySpeed) + Math.abs(b2.ySpeed);
  //double newTotal = Math.abs(B1XFEEL1) + Math.abs(B1XFEEL2) + Math.abs(B2XFEEL1) + Math.abs(B2XFEEL2) + Math.abs(B1YFEEL1) + Math.abs(B1YFEEL2) + Math.abs(B2YFEEL1) + Math.abs(B2YFEEL2);
  double newTotal2 = Math.abs(B1XFEEL1 + B1XFEEL2) + Math.abs(B1YFEEL1 + B1YFEEL2) + Math.abs(B2XFEEL1 + B2XFEEL2) + Math.abs(B2YFEEL1 + B2YFEEL2);
  double mult = systemTotal / newTotal2;
  //println("changing " + mult + " " + systemTotal + " " + newTotal);
  
  B1XFEEL1 *= mult;
  B1XFEEL2 *= mult;
  B2XFEEL1 *= mult;
  B2XFEEL2 *= mult;
  B1YFEEL1 *= mult;
  B1YFEEL2 *= mult;
  B2YFEEL1 *= mult;
  B2YFEEL2 *= mult;
  
  //println("FEELING ALL 1");
  //println(B2XFEEL1 + " | " + B2YFEEL1);
  //println(B1XFEEL1 + " | " + B1YFEEL1);
  //println("FEELING 2");
  //println(B2XFEEL2 + " | " + B2YFEEL2);
  //println(B1XFEEL2 + " | " + B1YFEEL2);
  
  b1.xSpeed = (float) (B1XFEEL1 + B1XFEEL2);
  b1.ySpeed = (float) (B1YFEEL1 + B1YFEEL2);
  b2.xSpeed = (float) (B2XFEEL1 + B2XFEEL2);
  b2.ySpeed = (float) (B2YFEEL1 + B2YFEEL2);
 
 if(tween) {
   b1.tween = b1.diameter / 3.0;
   b2.tween = b2.diameter / 3.0;
 } else {
   b1.tween = 0;
   b2.tween = 0;
 }
  
  //run = false;
  
}

public void collide2(Ball b1, Ball b2) {
  //run = false;
  /*
   * When Ball1 hits Ball2, Ball1's force vector is the component of its original velocity
   * which lies on the contactSlope. Ball2's new force vector is the component of Ball1's
   * velocity which is perpendicular to the slope of contact.
   */
  double perpContact = (b1.yLoc - b2.yLoc) / (b1.xLoc - b2.xLoc);
  double contactSlope = -1.0 / perpContact;
  
  // With Ball1 the center, angle of distortion from normal X acis to perpendicular contact
  double xDiff = b2.xLoc - b1.xLoc;
  double yDiff = b2.yLoc - b1.yLoc;
  
  //println(xDiff + " " + yDiff);
  //println(Math.toDegrees(Math.atan(yDiff/xDiff)));
  //println(Math.toDegrees(Math.atan(-xDiff/yDiff)));
  
  double angleDist = Math.abs(Math.toDegrees(Math.atan(yDiff/xDiff)));
  println(Math.abs(Math.toDegrees(Math.atan(yDiff/xDiff))));
  println(Math.abs(Math.toDegrees(Math.atan(-xDiff/yDiff))));
  
  double hyp = Math.sqrt(Math.pow(b1.xSpeed,2) + Math.pow(b1.ySpeed,2));
  double opp = Math.sin(Math.toRadians(angleDist)) * hyp;
  double adj = Math.cos(Math.toRadians(angleDist)) * hyp;
  
  println("First adj " + adj);

  double b1x1 = Math.cos(Math.toRadians(Math.abs(90 - angleDist))) * opp;
  double b1y1 = Math.sin(Math.toRadians(Math.abs(90 - angleDist))) * opp;
  
  double b2x1 = Math.cos(Math.toRadians(Math.abs(angleDist))) * adj;
  double b2y1 = Math.sin(Math.toRadians(Math.abs(angleDist))) * adj;
  
  xDiff = b1.xLoc - b2.xLoc;
  yDiff = b1.yLoc - b2.yLoc;
  
  //println(xDiff + " " + yDiff);
  //println(Math.toDegrees(Math.atan(yDiff/xDiff)));
  //println(Math.toDegrees(Math.atan(-xDiff/yDiff)));
  
  angleDist = Math.abs(Math.toDegrees(Math.atan(yDiff/xDiff)));
  println(angleDist);
  
  hyp = Math.sqrt(Math.pow(b2.xSpeed,2) + Math.pow(b2.ySpeed,2));
  opp = Math.sin(Math.toRadians(angleDist)) * hyp;
  adj = Math.cos(Math.toRadians(angleDist)) * hyp;
  
  println(hyp + " " + opp + " " + adj);
  
  double b2x2 = Math.cos(Math.toRadians(Math.abs(90 - angleDist))) * opp;
  double b2y2 = Math.sin(Math.toRadians(Math.abs(90 - angleDist))) * opp;
  
  double b1x2 = Math.cos(Math.toRadians(Math.abs(angleDist))) * adj;
  double b1y2 = Math.sin(Math.toRadians(Math.abs(angleDist))) * adj;
  
  float b1nx = 0;
  float b1ny = 0;
  float b2nx = 0;
  float b2ny = 0;

  xDiff = b2.xLoc - b1.xLoc;
  yDiff = b2.yLoc - b1.yLoc;

  if(xDiff > 0 && yDiff <= 0) {
    println("Q1");
    // Quadrant 1 (Above right X-axis)
    b1nx = (float) (Math.signum(b1.xSpeed) * b1x1 + -b1x2);
    b1ny = (float) (Math.signum(b1.ySpeed) * b1y1 + b1y2);
    b2nx = (float) (b2x1 + Math.signum(b2.xSpeed) * b2x2);
    b2ny = (float) (-b2y1 + Math.signum(b2.ySpeed) * b2y2);
  } else if(xDiff < 0 && yDiff <= 0) {
    println("Q2");
    // Quadrant 2 (Above left X-axis)
    b1nx = (float) (Math.signum(b1.xSpeed) * b1x1 + b1x2);
    b1ny = (float) (Math.signum(b1.ySpeed) * b1y1 + b1y2);
    b2nx = (float) (b2x1 + Math.signum(b2.xSpeed) * b2x2);
    b2ny = (float) (-b2y1 + Math.signum(b2.ySpeed) * b2y2);
    println(b2ny + " " + b1.ySpeed + " " + b2.ySpeed + " " + Math.signum(b1.ySpeed));
  } else if(xDiff <= 0 && yDiff > 0) {
    println("Q3");
    // Quadrant 3 (Below left X-axis)
    b1nx = (float) (Math.signum(b1.xSpeed) * b1x1 + b1x2);
    b1ny = (float) (Math.signum(b1.ySpeed) * b1y1 + -b1y2);
    b2nx = (float) (-b2x1 + Math.signum(b2.xSpeed) * b2x2);
    b2ny = (float) (b2y1 + Math.signum(b2.ySpeed) * b2y2);
    println(b2y1 + " | " + angleDist);
  } else if(xDiff >= 0 && yDiff > 0) {
    println("Q4");
    // Quadrant 4 (Below right X-axis)
    b1nx = (float) (Math.signum(b1.xSpeed) * b1x1 + -b1x2);
    b1ny = (float) (Math.signum(b1.ySpeed) * b1y1 + -b1y2);
    b2nx = (float) (b2x1 + Math.signum(b2.xSpeed) * b2x2);
    b2ny = (float) (b2y1 + Math.signum(b2.ySpeed) * b2y2);
  }
  
  b1.xSpeed = b1nx;
  b1.ySpeed = b1ny;
  b2.xSpeed = b2nx;
  b2.ySpeed = b2ny;
  //run = false;
  
}

public void collide(Ball b1, Ball b2) {
    float speed = Math.abs(b1.xSpeed) + Math.abs(b2.xSpeed);
    b1.xSpeed = (float) Math.signum(b1.xSpeed) * speed * (float) b2.diameter / (float) (b1.diameter + b2.diameter);
    b2.xSpeed = (float) Math.signum(b2.xSpeed) * speed * (float) b1.diameter / (float) (b1.diameter + b2.diameter);
    //println(speed + " " + b1.xSpeed + " " + b2.xSpeed);
    
    speed = Math.abs(b1.ySpeed) + Math.abs(b2.ySpeed);
    b1.ySpeed = (float) Math.signum(b1.ySpeed) * speed * (float) b2.diameter / (float) (b1.diameter + b2.diameter);
    b2.ySpeed = (float) Math.signum(b2.ySpeed) * speed * (float) b1.diameter / (float) (b1.diameter + b2.diameter);
    
    if(Math.signum(b1.getXSpeed()) != Math.signum(b2.getXSpeed())) {
      if(b1.xLoc < b2.xLoc) {
        b1.xSpeed = -Math.abs(b1.xSpeed);
        b2.xSpeed = Math.abs(b2.xSpeed);
      } else {
        b1.xSpeed = Math.abs(b1.xSpeed);
        b2.xSpeed = -Math.abs(b2.xSpeed);
      }
    } else {
      if(b1.xSpeed > 0 && b1.xLoc < b2.xLoc && b1.xSpeed > b2.xSpeed) {
        b1.xSpeed = -Math.abs(b1.xSpeed);
      } else if(b1.xSpeed > 0 && b2.xLoc < b1.xLoc && b2.xSpeed > b1.xSpeed) {
        b2.xSpeed = -Math.abs(b2.xSpeed);
      } else if(b1.xSpeed < 0 && b1.xLoc < b2.xLoc && b2.xSpeed < b1.xSpeed) {
        b2.xSpeed = Math.abs(b2.xSpeed);
      } else if(b1.xSpeed < 0 && b2.xLoc < b1.xLoc && b1.xSpeed < b2.xSpeed) {
        b1.xSpeed = Math.abs(b1.xSpeed);
      }
    }
    
    if(Math.signum(b1.getYSpeed()) != Math.signum(b2.getYSpeed())) {
      if(b2.yLoc < b1.yLoc) {
        b1.ySpeed = -Math.abs(b1.ySpeed);
        b2.ySpeed = Math.abs(b2.ySpeed);
      } else {
        b1.ySpeed = -Math.abs(b1.ySpeed);
        b2.ySpeed = Math.abs(b2.ySpeed);
      }
    } else {
      if(b1.ySpeed > 0 && b1.yLoc < b2.yLoc && b1.ySpeed > b2.ySpeed) {
        b1.ySpeed = -Math.abs(b1.ySpeed);
      } else if(b1.ySpeed > 0 && b2.yLoc < b1.yLoc && b2.ySpeed > b1.ySpeed) {
        b2.ySpeed = -Math.abs(b2.ySpeed);
      } else if(b1.ySpeed < 0 && b1.yLoc > b1.yLoc && b2.ySpeed > b1.ySpeed) {
        b2.ySpeed = Math.abs(b2.ySpeed);
      } else if(b1.ySpeed < 0 && b2.yLoc > b1.yLoc && b2.ySpeed < b1.ySpeed) {
        b2.ySpeed = Math.abs(b2.ySpeed);
      }
    }
  }

public void newBall(Ball b) {
  Ball add = new Ball(randomSize(), randomX() * Math.signum(b.getXSpeed()), randomY() * Math.signum(b.getYSpeed()), b.getX(), b.getY(), randomColor(), randomColor(), randomStroke());
  balls.add(add);
}

public int randomStroke() {
  return ((int) (Math.random() * 10) + 3);
}

public int randomSize() {
  return (int) (Math.random() * 30) + 30;
}

public float randomX() {
  return (float) (Math.random() * 8) + 5;
}

public float randomY() {
  return (float) (Math.random() * 8) + 5;
}

void mousePressed() {
  if(mouseX > 1450 && mouseX < 1480 && mouseY > 677.5 && mouseY < 707.5) {
    tween =! tween;
    if(!tween) {
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).tween = 0;
        balls.get(i).tweenAllow = false;
      }
    } else {
      for(int i = 0; i < balls.size(); i ++) {
        balls.get(i).tween = 0;
        balls.get(i).tweenAllow = true;
      }
    }
  } else {
    run = !run;
  }
}

class Ball {
  public int diameter;
  public float xSpeed;
  public float ySpeed;
  public float xLoc;
  public float yLoc;
  public int ballColor;
  public int ballStroke;
  public int strokeSize;
  public float tween = 0;
  public boolean tweenAllow = true;
  
  public Ball(int diameter, float xSpeed, float ySpeed, float x, float y, int ballColor, int ballStroke, int strokeSize) {
    this.diameter = diameter;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    xLoc = x;
    yLoc = y;
    this.ballColor = ballColor;
    this.ballStroke = ballStroke;
    this.strokeSize = strokeSize;
  }
  
  public int getSize() {
    return diameter;
  }
  
  public float getXSpeed() {
    return xSpeed;
  }
  
  public float getYSpeed() {
    return ySpeed;
  }
  
  public float getX() {
    return xLoc;
  }
  
  public float getY() {
    return yLoc;
  }
  
  public int getColor() {
    return ballColor;
  }
  
  public int getStroke() {
    return ballStroke;
  }
  
  public int getStrokeSize() {
    return strokeSize;
  }
  
  public float radius() {
    return diameter/2 + strokeSize/2;
  }
  
  public void increment() {
    if((yLoc + diameter/2 + 2 * strokeSize > 720 && ySpeed > 0) || (yLoc - diameter/2 - 2 * strokeSize < 0 && ySpeed < 0)) {
      ySpeed *= -1;
      if(this.tweenAllow) {
        this.tween = this.diameter / 2.0;
      }
      if(balls.size() < maxBalls) {
        newBall(this);
      }
    }
    if((xLoc + diameter/2 + 2 * strokeSize > 1280 && xSpeed > 0) || (xLoc - diameter/2 - 2 * strokeSize < 0 && xSpeed < 0)) {
      xSpeed *= -1;
      if(this.tweenAllow) {
        this.tween = this.diameter / 2.0;
      }
      if(balls.size() < maxBalls) {
        newBall(this);
      }
    }
    xLoc += xSpeed;
    yLoc += ySpeed;
    
    tween = 0.9 * tween;
    
  }
  
  public void flipX() {
    xSpeed *= -1;
  }
  
  public void flipY() {
    ySpeed *= -1;
  }
  
  public void setXSpeed(float x) {
    this.xSpeed = x;
  }
  
  public void setYSpeed(float y) {
    this.ySpeed = y;
  }
  
  public void speedX() {
    if(xSpeed == 0) {
      xSpeed += 0.5;
    } else {
      xSpeed += Math.signum(xSpeed) / 2.0;
    }
  }
  
  public void speedY() {
    if(ySpeed == 0) {
      ySpeed += 0.5;
    } else {
      ySpeed += Math.signum(ySpeed) / 2.0;
    }
  }
  
  public void decSpeedX() {
    xSpeed -= Math.signum(xSpeed) / 2.0;
  }
  
  public void decSpeedY() {
    ySpeed -= Math.signum(ySpeed) / 2.0;
  }
  
  public void incSize() {
    diameter += 5;
  }
  
  public void decSize() {
    diameter -= 5;
  }
}
