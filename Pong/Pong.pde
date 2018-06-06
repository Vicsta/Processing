/*
 * @Author Victor Treaba
 * Game of Pong supporting one or two players OR FOUR
 */
 
int gameMode = 0, hover = -1, numPlayers = 0, numAI = 0;
ArrayList<Player> players = new ArrayList<Player>(), AI = new ArrayList<Player>();
ArrayList<Ball> balls;
ArrayList<Integer> points;
/*
 * 0 - Menu
 * 1 - SinglePlayer Menu
 * 2 - Multiplayer Menu
 * 3 - Options Menu
 */

boolean firstTime = true, run = false;

boolean p1Up, p1Down, p2Up, p2Down;
boolean p3Left, p3Right, p4Left, p4Right;

int winner = -1;

void setup() {
  size(1280, 720);
}

void mouseClicked() {
  //println(hover);
  if(gameMode == 0) {
    if(hover == 0) {
      gameMode = 1;
      numPlayers = 1;
      numAI = 0;
      players = new ArrayList<Player>();
      AI = new ArrayList<Player>();
      p1Up = p1Down = p2Up = p2Down = p3Left = p3Right = p4Left = p4Right = false;
    } else if(hover == 1) {
      gameMode = 2;
      numPlayers = 2;
      numAI = 0;
      players = new ArrayList<Player>();
      AI = new ArrayList<Player>();
      p1Up = p1Down = p2Up = p2Down = p3Left = p3Right = p4Left = p4Right = false;
    } else if(hover == 2) {
      gameMode = 4;
    } else if(hover == 18) {
      System.exit(0);
    }
  } else if(gameMode == 1) {
    if(hover == 0) {
    // Two player game
    numAI = 1;
    } else if(hover == 1) {
    // Four player game 
    numAI = 3;
    } else if(hover >= 2 && hover <= 9) {
      if(hover == 2) {
        if(players.get(0).paddleType > 0) {
          players.get(0).paddleType --;
        } else {
          players.get(0).paddleType = 2;
        }
      } else if(hover == 3) {
        if(players.get(0).paddleType < 2) {
          players.get(0).paddleType ++;
        } else {
          players.get(0).paddleType = 0;
        }
      } else if(hover % 2 == 0) {
        int index = hover/2 - 2;
        if(AI.get(index).paddleType > 0) {
          AI.get(index).paddleType --;
        } else {
          AI.get(index).paddleType = 2;
        }
      } else {
        int index = (hover - 1)/2 - 2;
        if(AI.get(index).paddleType < 2) {
          AI.get(index).paddleType ++;
        } else {
          AI.get(index).paddleType = 0;
        }
      }
    } else if(hover >= 10 && hover <= 17) {
      if(hover == 10 || hover == 11) {
        players.get(0).playerRed = (int) (Math.random() * 256);
        players.get(0).playerGreen = (int) (Math.random() * 256);
        players.get(0).playerBlue = (int) (Math.random() * 256);
      } else if(hover % 2 == 0) {
        int index = hover/2 - 6;
        AI.get(index).playerRed = (int) (Math.random() * 256);
        AI.get(index).playerGreen = (int) (Math.random() * 256);
        AI.get(index).playerBlue = (int) (Math.random() * 256);
      } else {
        int index = (hover - 1)/2 - 6;
        AI.get(index).playerRed = (int) (Math.random() * 256);
        AI.get(index).playerGreen = (int) (Math.random() * 256);
        AI.get(index).playerBlue = (int) (Math.random() * 256);
      }
    } else if(hover == 18) {
      gameMode = 0;
    } else if(hover == 19) {
      balls = new ArrayList<Ball>();
      points = new ArrayList<Integer>();
      for(int i = 0; i < players.size() + AI.size(); i ++) {
        points.add(0);
      }
      winner = -1;
      firstTime = true;
      run = false;
      gameMode = 3;
    }
  } else if(gameMode == 2) {
    if(hover == 0) {
    numPlayers = 2;
    } else if(hover == 1) {
      numPlayers = 4;
      if(numAI > 0) {
        numAI = 0;
      }
    } else if(hover == 2) {
      numAI = 0;
    } else if(hover == 3) {
      numAI = 2;
      if(numPlayers > 2) {
        numPlayers = 2;
      }
    } else if(hover >= 4 && hover <= 19) {
    // Bad but easy, don't do this in big games wastes time and space
    ArrayList<Player> refs = new ArrayList<Player>();
    
    for(int i = 0; i < players.size(); i ++) {
      refs.add(players.get(i));
    }
    for(int i = 0; i < AI.size(); i ++) {
      refs.add(AI.get(i));
    }
    
    int index = 0;
    
    if(hover < 12) {
      // Paddle shapes
      if(hover % 2 == 0) {
        // Left button
        index = hover / 2 - 2;
        if(refs.get(index).paddleType > 0) {
          refs.get(index).paddleType --;
        } else {
          refs.get(index).paddleType = 2;
        }
      } else {
        // Right button
        index = (hover - 1) / 2 - 2;
        if(refs.get(index).paddleType < 2) {
          refs.get(index).paddleType ++;
        } else {
          refs.get(index).paddleType = 0;
        }
      }
    } else {
      // Paddle color
      if(hover % 2 == 0) {
        // Left button
        index = hover / 2 - 6;
        refs.get(index).playerRed = (int) (Math.random() * 256);
        refs.get(index).playerGreen = (int) (Math.random() * 256);
        refs.get(index).playerBlue = (int) (Math.random() * 256);
      } else {
        // Right button
        index = (hover - 1) / 2 - 6;
        refs.get(index).playerRed = (int) (Math.random() * 256);
        refs.get(index).playerGreen = (int) (Math.random() * 256);
        refs.get(index).playerBlue = (int) (Math.random() * 256);
      }  
    }
        
    } else if(hover == 100) {  
      gameMode = 0;
    } else if(hover == 101) {
      balls = new ArrayList<Ball>();
      points = new ArrayList<Integer>();
      for(int i = 0; i < players.size() + AI.size(); i ++) {
        points.add(0);
      }
      winner = -1;
      firstTime = true;
      run = false;
      gameMode = 3;
    }
  } else if(gameMode == 3) {
    if(hover == 100) {
      gameMode = 0;
    }
  } else if(gameMode == 4) {
    if(hover == 100) {
      gameMode = 0;
    }
  }
}

void draw() {
  if(gameMode == 0) {
    drawMenu();
  } else if(gameMode == 1) {
    drawSinglePlayerMenu();
  } else if(gameMode == 2) {
    drawMultiPlayerMenu();
  } else if(gameMode == 3) {
    drawGame();
  } else if(gameMode == 4) {
    drawOptions();
  }
}

public void drawGame() {
  background(0);
  
  ArrayList<Player> gamePlay = new ArrayList<Player>();
  for(int i = 0; i < players.size(); i ++) {
    gamePlay.add(players.get(i));
  }
  for(int i = 0; i < AI.size(); i ++) {
    gamePlay.add(AI.get(i));
  }
    
  //Draw the score
  textSize(200);
  for(int i = 0; i < points.size(); i ++) {
    Player p = gamePlay.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    float x = 0, y = 0;
    if(i == 0) {
      x = 200;
      y = height/2 + 70;
    } else if(i == 1) {
      x = width - 200 - textWidth(points.get(i) + "");
      y = height/2 + 70;
    } else if(i == 2) {
      x = width/2 - textWidth(points.get(i) + "")/2;
      y = 200;
    } else if(i == 3) {
      x = width/2 - textWidth(points.get(i) + "")/2;
      y = height - 57;
    }
    text(points.get(i) + "", x, y);
  }
  
  stroke(255);
  for(int i = 0; i < gamePlay.size(); i++) {
    Player p = gamePlay.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    if(i <= 1) {
      if(p.paddleType == 0) {
        rect(p.paddleX, p.paddleY, p.paddleHeight, p.paddleLength);
      } else if(p.paddleType == 1) {
        rect(p.paddleX, p.paddleY + p.paddleHeight, p.paddleHeight, p.paddleLength - 2*p.paddleHeight);
        ellipse(p.paddleX + p.paddleHeight/2.0, p.paddleY + p.paddleHeight, p.paddleHeight, 2*p.paddleHeight);
        ellipse(p.paddleX + p.paddleHeight/2.0, p.paddleY + p.paddleLength - p.paddleHeight, p.paddleHeight, 2*p.paddleHeight);
      } else if(p.paddleType == 2) {
        rect(p.paddleX, p.paddleY + p.paddleHeight, p.paddleHeight, p.paddleLength - 2*p.paddleHeight);
        triangle(p.paddleX, p.paddleY + p.paddleHeight, p.paddleX + p.paddleHeight, p.paddleY + p.paddleHeight, p.paddleX + p.paddleHeight/2.0, p.paddleY);
        triangle(p.paddleX, p.paddleY + p.paddleLength - p.paddleHeight, p.paddleX + p.paddleHeight, p.paddleY + p.paddleLength - p.paddleHeight, p.paddleX + p.paddleHeight/2.0, p.paddleY + p.paddleLength);
      }
    } else if(i <= 4) {
      if(p.paddleType == 0) {
        rect(p.paddleX, p.paddleY, p.paddleLength, p.paddleHeight);
      } else if(p.paddleType == 1) {
        rect(p.paddleX + p.paddleHeight, p.paddleY, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
        ellipse(p.paddleX + p.paddleHeight, p.paddleY + p.paddleHeight/2.0, 2*p.paddleHeight, p.paddleHeight);
        ellipse(p.paddleX + p.paddleLength - p.paddleHeight, p.paddleY + p.paddleHeight/2.0, 2*p.paddleHeight, p.paddleHeight);
      } else if(p.paddleType == 2) {
        rect(p.paddleX + p.paddleHeight, p.paddleY, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
        triangle(p.paddleX + p.paddleHeight, p.paddleY, p.paddleX + p.paddleHeight, p.paddleY + p.paddleHeight, p.paddleX, p.paddleY + p.paddleHeight/2.0);
        triangle(p.paddleX + p.paddleLength - p.paddleHeight, p.paddleY, p.paddleX + p.paddleLength - p.paddleHeight, p.paddleY + p.paddleHeight, p.paddleX + p.paddleLength, p.paddleY + p.paddleHeight/2.0);
      }
    }
  }
  
  // Draw bumpers for players 3 and 4
  if(gamePlay.size() > 2) {
    fill(gamePlay.get(2).playerRed, gamePlay.get(2).playerGreen, gamePlay.get(2).playerBlue);
    rect(0, 0, 280, 10);
    rect(width - 280, 0, 280, 10);
    fill(gamePlay.get(3).playerRed, gamePlay.get(3).playerGreen, gamePlay.get(3).playerBlue);
    rect(0, height - 10, 280, 10);
    rect(width - 280, height - 10, 280, 10);
  } else {
    // Draw bumpers for 2 players
    fill(gamePlay.get(0).playerRed, gamePlay.get(0).playerGreen, gamePlay.get(0).playerBlue);
    rect(0, 0, width, 10);
    fill(gamePlay.get(1).playerRed, gamePlay.get(1).playerGreen, gamePlay.get(1).playerBlue);
    rect(0, height - 10, width, 10);
  }
  
  // Fewer balls than players
  if(balls.size() < gamePlay.size()) {
    for(int i = 0; i < gamePlay.size(); i ++) {
      boolean found = false;
      for(int j = 0; j < balls.size(); j ++) {
        if(balls.get(j).player == i) {
          found = true;
        }
      }
      if(!found) {
        //println("adding new ball");
        balls.add(new Ball(i));
      }
    }
  }
  
  for(int i = 0; i < balls.size(); i ++) {
    Ball b = balls.get(i);
    Player p = gamePlay.get(b.player);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    translate(b.xLoc, b.yLoc);
    rotate((float) Math.atan(b.ySpeed / b.xSpeed));
    ellipse(0, 0, b.diameter - b.tween, b.diameter - b.tween/2);
    rotate((float) -Math.atan(b.ySpeed / b.xSpeed));
    translate(-b.xLoc, -b.yLoc);
    if(Math.abs(b.xSpeed) < 1) {
      b.xSpeed = Math.signum(b.xSpeed);
    }
    if(Math.abs(b.ySpeed) < 1) {
      b.ySpeed = Math.signum(b.xSpeed);
    }
  }
  
  if(run && winner < 0) {
    
    AImove();
    
    movePieces();
    
    collisions();
    
    for(int i = 0; i < balls.size(); i ++) {
      Ball b = balls.get(i);
      b.xLoc += b.xSpeed;
      b.yLoc += b.ySpeed;
      b.tween = 0.9 * b.tween;
      //println(b.xSpeed);
    }
    
    for(int i = 0; i < points.size(); i ++) {
      if(points.get(i) == 11) {
        winner = i;
      }
    }
    
  }
  
  if(winner >= 0) {
    fill(0);
    textSize(50);
    rect(width / 2.0 - 250, height / 2.0 - 300, 500, 100);
    fill(gamePlay.get(winner).playerRed, gamePlay.get(winner).playerGreen, gamePlay.get(winner).playerBlue);
    text("Player " + (winner + 1) + " WINS!", width / 2.0 - textWidth("Player " + (winner + 1) + " WINS!") / 2.0, height / 2.0 - 235);
  }
  
  
  /*
   * SET UP THE GAME ON FIRST OPENING
   */
  if(firstTime) {
    fill(0);
    stroke(255);
   // rect(width / 2.0 - 250, height / 2.0 - 300, 500, 100);
    fill(255);
    textSize(50);
    text("Press Space to Start", width / 2.0 - textWidth("Press Space to Start") / 2.0, height / 2.0 - 235);
    
    for(int i = 0; i < gamePlay.size(); i ++) {
      Player p = gamePlay.get(i);
      if(i == 0) {
        p.paddleX = 10;
        p.paddleY = height/2 - p.paddleLength/2;
      } else if(i == 1) {
        p.paddleX = width - 10 - p.paddleHeight;
        p.paddleY = height/2 - p.paddleLength/2;
      } else if(i == 2) {
        p.paddleX = width/2 - p.paddleLength/2;
        p.paddleY = 10;
      } else if(i == 3) {
        p.paddleX = width/2 - p.paddleLength/2;
        p.paddleY = height - 10 - p.paddleHeight;
      }
      if(p.paddleType == 0) {
        p.paddleSpeed = 6;
        p.paddleStr = 7;
      } else if(p.paddleType == 1) {
        p.paddleSpeed = 4;
        p.paddleStr = 9;
      } else if(p.paddleType == 2) {
        p.paddleSpeed = 8;
        p.paddleStr = 5;
      }
    }
  } else if(!run) {
    stroke(255);
    fill(0);
   // rect(width / 2.0 - 250, height / 2.0 - 300, 500, 100);
    fill(255);
    textSize(50);
    text("GAME PAUSED", width / 2.0 - textWidth("GAMEPAUSED") / 2.0, height / 2.0 - 235);
    textSize(30);
    text("Press Space", width / 2.0 - textWidth("Press Space") / 2.0, height / 2.0 + 33 - 235);
  }
  
  boolean hovering = false;
  
  if(!run || winner >= 0) {
    if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 100;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    rect(10, 10, 200, 75);
    if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);
    }
    textSize(50);
    text("BACK", 10 + 100 - textWidth("BACK")/2.0, 65);
  }

  if(!run) {
    fill(0);
    stroke(255);
    if(players.size() == 2) {
      rect(200, 200, width - 400, 200);
    } else if(players.size() > 2) {
      rect(200, 200, width - 400, 375);
    } else if(players.size() == 1) {
      rect(200 + (width - 400)/4, 200, (width - 400)/2, 200);
    }
    
    if(players.size() >= 2) {
      noStroke();
      rect(225, 225, (width - 400) / 2 - 50, 200 - 50);
      rect(200 + width - 400 - (width - 400) / 2 + 25, 225, (width - 400) / 2 - 50, 200 - 50);
      stroke(255);
      fill(players.get(0).playerRed, players.get(0).playerGreen, players.get(0).playerBlue);
      text("Player1",((width - 400) / 2 - 50)/2 + 225 - textWidth("Player1")/2, 225 + 50);
      
      rect(225, 225 + 150 - 70, 70, 70, 20, 0, 20, 0);
      textSize(40);
      text("Up", 225 + 70 + 10, 225 + 150 - 17);
      rect(225 + 160, 225 + 150 - 70, 70, 70, 0, 20, 0, 20); 
      text("Down", 225 + 70 + 10 + 160, 225 + 150 - 17);
      textSize(50);
      fill(0);
      text("W", 225 + 14, 225 + 150 - 17);
      text("S", 225 + 24 + 160, 225 + 150 - 17);
      
      fill(players.get(1).playerRed, players.get(1).playerGreen, players.get(1).playerBlue);
      text("Player2", ((width - 400) / 2 - 50)/2 + 200 + width - 400 - (width - 400) / 2 + 25 - textWidth("Player2")/2, 225 + 50);
      
      rect(200 + width - 400 - (width - 400) / 2 + 25, 225 + 150 - 70, 70, 70, 20, 0, 20, 0);
      textSize(40);
      text("Up", 200 + width - 400 - (width - 400) / 2 + 25 + 70 + 10, 225 + 150 - 22);
      rect(200 + width - 400 - (width - 400) / 2 + 25 + 160, 225 + 150 - 70, 70, 70, 0, 20, 0, 20);
      text("Down", 200 + width - 400 - (width - 400) / 2 + 25 + 70 + 10 + 160, 225 + 150 - 22);
      textSize(50);
      fill(0);
      text("↑", 200 + width - 400 - (width - 400) / 2 + 25 + 20, 225 + 150 - 22);
      text("↓", 200 + width - 400 - (width - 400) / 2 + 25 + 20 + 160, 225 + 150 - 22);
      
      if(players.size() > 2) {
        noStroke();
        fill(0);
        rect(225, 225 + 150 + 25, (width - 400) / 2 - 50, 200 - 50);
        rect(200 + width - 400 - (width - 400) / 2 + 25, 225 + 150 + 25, (width - 400) / 2 - 50, 200 - 50);
        stroke(255);
        
        fill(players.get(2).playerRed, players.get(2).playerGreen, players.get(2).playerBlue);
        text("Player3",((width - 400) / 2 - 50)/2 + 225 - textWidth("Player3")/2, 225 + 150 + 25 + 50);
        
        rect(225, 225 + 150 + 25 + 150 - 70, 70, 70, 0, 20, 0, 20);
        textSize(40);
        text("Left", 225 + 70 + 10, 225 + 150 + 25 + 150 - 22);
        rect(225 + 160, 225 + 150 + 25 + 150 - 70, 70, 70, 20, 0, 20, 0);
        text("Right", 225 + 70 + 10 + 160, 225 + 150 + 25 + 150 - 22);
        fill(0);
        textSize(50);
        text("C", 225 + 17, 225 + 150 + 25 + 150 - 17);
        text("V", 225 + 20 + 160 - 2, 225 + 150 + 25 + 150 - 18);
        
        fill(players.get(3).playerRed, players.get(3).playerGreen, players.get(3).playerBlue);
        text("Player4", ((width - 400) / 2 - 50)/2 + 200 + width - 400 - (width - 400) / 2 + 25 - textWidth("Player4")/2, 225 + 150 + 25 + 50);
        
        rect(200 + width - 400 - (width - 400) / 2 + 25, 225 + 150 + 25 + 150 - 70, 70, 70, 0, 20, 0, 20);
        textSize(40);
        text("Left", 200 + width - 400 - (width - 400) / 2 + 25 + 70 + 10, 225 + 150 + 25 + 150 - 22);
        rect(200 + width - 400 - (width - 400) / 2 + 25 + 160, 225 + 150 + 25 + 150 - 70, 70, 70, 20, 0, 20, 0);
        text("Right", 200 + width - 400 - (width - 400) / 2 + 25 + 70 + 10 + 160, 225 + 150 + 25 + 150 - 22);
        fill(0);
        textSize(50);
        text("N", 200 + width - 400 - (width - 400) / 2 + 25 + 17, 225 + 150 + 25 + 150 - 17);
        text("M", 200 + width - 400 - (width - 400) / 2 + 25 + 14 + 160, 225 + 150 + 25 + 150 - 17);
      }
    } else {
      noStroke();
      rect(200 + (width - 400)/4 + 25, 200 + 25, (width - 400)/2 - 50, 200 - 50);
      stroke(255);
      fill(players.get(0).playerRed, players.get(0).playerGreen, players.get(0).playerBlue);
      text("Player1",((width - 400) / 2 - 50)/2 + (width - 400)/4 + 200 + 25 - textWidth("Player1")/2, 225 + 50);
      rect(200 + (width - 400)/4 + 25, 225 + 150 - 70, 70, 70);
      text("Up", 200 + (width - 400)/4 + 25 + 70 + 10, 225 + 150 - 17);
      rect(200 + (width - 400)/4 + 25 + 160, 225 + 150 - 70, 70, 70); 
      text("Down", 200 + (width - 400)/4 + 25 + 70 + 10 + 160, 225 + 150 - 17);
      fill(0);
      text("W", 200 + (width - 400)/4 + 25 + 14, 225 + 150 - 17);
      text("S", 200 + (width - 400)/4 + 25 + 24 + 160, 225 + 150 - 17);
    }
    
  }
  
  if(!hovering) {
    hover = -1;
    cursor(ARROW);
  }
  
}

public double distBallCoord(Ball b, float x, float y) {
  return Math.sqrt(Math.pow(b.xLoc - x, 2) + Math.pow(b.yLoc - y, 2));
}

public void AImove() {
  if(AI.size() > 0) {
    for(int i = 0; i < AI.size(); i ++) {
      if(i + players.size() == 1) {
        // AI is player 2
        Ball closest = balls.get(0);
        for(int j = 0; j < balls.size(); j ++) {
          Ball b = balls.get(j);
          if(distBallCoord(b, AI.get(i).paddleX, AI.get(i).paddleY) < distBallCoord(closest, AI.get(i).paddleX, AI.get(i).paddleY) && b.xSpeed > 0) {
            closest = b;
          }
        }
        if(closest.yLoc < AI.get(i).paddleY) {
          p2Up = true;
          p2Down = false;
        } else if(closest.yLoc > AI.get(i).paddleY + AI.get(i).paddleLength) {
          p2Down = true;
          p2Up = false;
        } else {
          p2Down = false;
          p2Up = false;
        }
      } else if(i + players.size() == 2) {
        // AI is player 3
        Ball closest = balls.get(0);
        for(int j = 0; j < balls.size(); j ++) {
          Ball b = balls.get(j);
          if(distBallCoord(b, AI.get(i).paddleX, AI.get(i).paddleY) < distBallCoord(closest, AI.get(i).paddleX, AI.get(i).paddleY) && b.ySpeed < 0) {
            closest = b;
          }
        }
        if(closest.xLoc > AI.get(i).paddleX + AI.get(i).paddleLength) {
          p3Right = true;
          p3Left = false;
        } else if (closest.xLoc < AI.get(i).paddleX){
          p3Left = true;
          p3Right = false;
        } else {
          p3Left = false;
          p3Right = false;
        }
      } else if(i + players.size() == 3) {
        // AI is player 4
        Ball closest = balls.get(0);
        for(int j = 0; j < balls.size(); j ++) {
          Ball b = balls.get(j);
          if(distBallCoord(b, AI.get(i).paddleX, AI.get(i).paddleY) < distBallCoord(closest, AI.get(i).paddleX, AI.get(i).paddleY) && b.ySpeed > 0) {
            closest = b;
          }
        }
        if(closest.xLoc > AI.get(i).paddleX + AI.get(i).paddleLength) {
          p4Right = true;
          p4Left = false;
        } else if(closest.xLoc < AI.get(i).paddleX) {
          p4Left = true;
          p4Right = false;
        } else {
          p4Left = false;
          p4Right = false;
        }
      }
    }
  }
}

public void drawOptions() {
  background(0);
  fill(255);
  textSize(50);
  String text = "OPTIONS";
  text(text, width/2 - textWidth(text) / 2.0, 100);
  
  boolean hovering = false;
  hover = -1;
  
  textSize(30);
  text = "Hey it looks like I haven't thought of anything to put here yet :(";
  text(text, width/2 - textWidth(text)/2.0, 200);
  
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 100;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
  rect(10, 10, 200, 75);
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);
    }
  text("BACK", 10 + 100 - textWidth("BACK")/2.0, 65);
  
  if(!hovering) {
    hover = -1;
    cursor(ARROW);
  }
}

public void collisions() {

    for(int i = 0; i < balls.size(); i ++) {
    Ball b1 = balls.get(i);
    for(int j = i + 1; j < balls.size(); j ++) {
      Ball b2 = balls.get(j);
      if(dist(b1, b2) <= b1.diameter/2 + b2.diameter/2) {
        collide3(b1, b2);
      }
    }
  }
  
  ArrayList<Player> gamePlay = new ArrayList<Player>();
  for(int i = 0; i < players.size(); i ++) {
    gamePlay.add(players.get(i));
  }
  for(int i = 0; i < AI.size(); i ++) {
    gamePlay.add(AI.get(i));
  }
  
  for(int i = 0; i < balls.size(); i++) {
    Ball b = balls.get(i);
    Player p = gamePlay.get(b.player);
    float totalSpeed = (float) Math.sqrt(Math.pow(b.xSpeed, 2) + Math.pow(b.ySpeed, 2));
    for(int j = 0; j < gamePlay.size(); j++) {
      p = gamePlay.get(j);
      if(j == 0) {
        if(b.xLoc - b.diameter/2 <= p.paddleX + p.paddleHeight
        && b.yLoc >= p.paddleY && b.yLoc <= p.paddleY + p.paddleLength) {
          // 0 to p.paddleLength/2
          // 0 to 60 degrees
          float middle = p.paddleY + p.paddleLength/2;
          float distFromMid = middle - b.yLoc;
          if(distFromMid > 0) {
            // Hit up
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) -Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
          } else {
            // Hit down
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
          }
          b.tween = b.diameter / 2.0;
          /*
           * Scale up x and y components to match the paddle's strength
           */
          
           int str = p.paddleStr;
           
           if(Math.sqrt(Math.pow(b.xSpeed, 2) + Math.pow(b.ySpeed, 2)) != str) {
             double angle = Math.atan(Math.abs(b.ySpeed)/(double) Math.abs(b.xSpeed));
             // Str as hyp
             b.xSpeed = (float) (Math.signum(b.xSpeed) * Math.abs(str * Math.cos(angle)));
             b.ySpeed = (float) (Math.signum(b.ySpeed) * Math.abs(str * Math.sin(angle)));
           }
        }
      } else if(j == 1) {
        if(b.xLoc + b.diameter/2 >= p.paddleX
        && b.yLoc >= p.paddleY && b.yLoc <= p.paddleY + p.paddleLength) {
          // 0 to p.paddleLength/2
          // 0 to 60 degrees
          float middle = p.paddleY + p.paddleLength/2;
          float distFromMid = middle - b.yLoc;
          if(distFromMid > 0) {
            // Hit up
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) -Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) -Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
          } else {
            // Hit down
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) -Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
          }
          b.tween = b.diameter / 2.0;
          /*
           * Scale up x and y components to match the paddle's strength
           */
          
           int str = p.paddleStr;
           
           if(Math.sqrt(Math.pow(b.xSpeed, 2) + Math.pow(b.ySpeed, 2)) != str) {
             double angle = Math.atan(Math.abs(b.ySpeed)/(double) Math.abs(b.xSpeed));
             // Str as hyp
             b.xSpeed = (float) (Math.signum(b.xSpeed) * Math.abs(str * Math.cos(angle)));
             b.ySpeed = (float) (Math.signum(b.ySpeed) * Math.abs(str * Math.sin(angle)));
           }
        }
      } else if(j == 2) {  
        if(b.yLoc - b.diameter/2 <= p.paddleY + p.paddleHeight
        && b.xLoc >= p.paddleX && b.xLoc <= p.paddleX + p.paddleLength) {
          // 0 to p.paddleLength/2
          // 0 to 60 degrees
          float middle = p.paddleX + p.paddleLength/2;
          float distFromMid = middle - b.xLoc;
          if(distFromMid > 0) {
            // Hit up
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) -Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
          } else {
            // Hit down
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
          }
          b.tween = b.diameter / 2.0;
          /*
           * Scale up x and y components to match the paddle's strength
           */
          
           int str = p.paddleStr;
           
           if(Math.sqrt(Math.pow(b.xSpeed, 2) + Math.pow(b.ySpeed, 2)) != str) {
             double angle = Math.atan(Math.abs(b.ySpeed)/(double) Math.abs(b.xSpeed));
             // Str as hyp
             b.xSpeed = (float) (Math.signum(b.xSpeed) * Math.abs(str * Math.cos(angle)));
             b.ySpeed = (float) (Math.signum(b.ySpeed) * Math.abs(str * Math.sin(angle)));
           }
        }
      } else if(j == 3) {
        if(b.yLoc + b.diameter/2 >= p.paddleY
        && b.xLoc >= p.paddleX && b.xLoc <= p.paddleX + p.paddleLength) {
          // 0 to p.paddleLength/2
          // 0 to 60 degrees
          float middle = p.paddleX + p.paddleLength/2;
          float distFromMid = middle - b.xLoc;
          if(distFromMid > 0) {
            // Hit up
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) -Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) -Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
          } else {
            // Hit down
            float angle = (distFromMid / (p.paddleLength / 2)) * 65;
            b.xSpeed = (float) Math.abs(Math.sin(Math.toRadians(angle)) * totalSpeed);
            b.ySpeed = (float) -Math.abs(Math.cos(Math.toRadians(angle)) * totalSpeed);
          }
          b.tween = b.diameter / 2.0;
          /*
           * Scale up x and y components to match the paddle's strength
           */
          
           int str = p.paddleStr;
           
           if(Math.sqrt(Math.pow(b.xSpeed, 2) + Math.pow(b.ySpeed, 2)) != str) {
             double angle = Math.atan(Math.abs(b.ySpeed)/(double) Math.abs(b.xSpeed));
             // Str as hyp
             b.xSpeed = (float) (Math.signum(b.xSpeed) * Math.abs(str * Math.cos(angle)));
             b.ySpeed = (float) (Math.signum(b.ySpeed) * Math.abs(str * Math.sin(angle)));
           }
        }
      }
   
    }
  }
  
  for(int i = 0; i < balls.size(); i ++) {
    Ball b = balls.get(i);
    //Right side
    if(b.xLoc > width) {
      if(b.player != 1) {
        points.set(b.player, points.get(b.player) + 1);
      } else {
        points.set(1, points.get(1) - 1);
      }
      balls.remove(i);
      i --;
      continue;
    } else if(b.xLoc < 0) {
      if(b.player != 0) {
        points.set(b.player, points.get(b.player) + 1);
      } else {
        points.set(0, points.get(0) - 1);
      }
      balls.remove(i);
      i --;
      continue;
    }
    if(gamePlay.size() > 2) {
      if(b.yLoc > height) {
        if(b.player != 3) {
          points.set(b.player, points.get(b.player) + 1);
        } else {
          points.set(3, points.get(3) - 1);
        }
        balls.remove(i);
        i --;
      } else if(b.yLoc < 0) {
        if(b.player != 2) {
          points.set(b.player, points.get(b.player) + 1);
        } else {
          points.set(2, points.get(2) - 1);
        }
        balls.remove(i);
        i --;
      }
      if(b.yLoc + b.diameter/2 >= height - 10 && (b.xLoc <= 280 || b.xLoc >= width - 280)) {
        b.ySpeed = -Math.abs(b.ySpeed);
      } else if(b.yLoc - b.diameter/2 <= 10 && (b.xLoc <= 280 || b.xLoc >= width - 280)) {
        b.ySpeed = Math.abs(b.ySpeed);
      }
    } else {
      if(b.yLoc + b.diameter/2 >= height - 10) {
        b.ySpeed = -Math.abs(b.ySpeed);
      } else if(b.yLoc - b.diameter/2 <= 10) {
        b.ySpeed = Math.abs(b.ySpeed);
      }
    }
  }
  
}

public double dist(Ball b1, Ball b2) {
  return(Math.sqrt(Math.pow(b1.xLoc - b2.xLoc, 2) + Math.pow(b1.yLoc - b2.yLoc, 2)));
}

public void keyPressed() {
  if(gameMode == 3) {
    if(key == CODED) {
      if(keyCode == UP && run && players.size() >= 2) {
        p2Up = true;
      } else if(keyCode == DOWN && run && players.size() >= 2) {
        p2Down = true;
      }
    } else {
      if(key == 32 && winner < 0) {
        firstTime = false;
        run = !run;
      } else if(key == 's' && run) {
        p1Down = true;
      } else if(key == 'w' && run) {
        p1Up = true;
      } else if(key == 'c' && run && players.size() >= 3) {
        p3Left = true;
      } else if(key == 'v' && run && players.size() >= 3) {
        p3Right = true;
      } else if(key == 'n' && run && players.size() >= 4) {
        p4Left = true;
      } else if(key == 'm' && run && players.size() >= 4) {
        p4Right = true;
      }
    }
  }
}

public void keyReleased() {
    if(gameMode == 3) {
    if(key == CODED) {
      if(keyCode == UP && run && players.size() >= 2) {
        p2Up = false;
      } else if(keyCode == DOWN && run && players.size() >= 2) {
        p2Down = false;
      }
    } else {
      if(key == 's' && run) {
        p1Down = false;
      } else if(key == 'w' && run) {
        p1Up = false;
      } else if(key == 'c' && run && players.size() >= 3) {
        p3Left = false;
      } else if(key == 'v' && run && players.size() >= 3) {
        p3Right = false;
      } else if(key == 'n' && run && players.size() >= 4) {
        p4Left = false;
      } else if(key == 'm' && run && players.size() >= 4) {
        p4Right = false;
      }
    }
  }
}

public void movePieces() {
  if(run) {
    
    ArrayList<Player> gamePlay = new ArrayList<Player>();
    for(int i = 0; i < players.size(); i ++) {
      gamePlay.add(players.get(i));
    }
    for(int i = 0; i < AI.size(); i ++) {
      gamePlay.add(AI.get(i));
    }
    
    if(p1Down) {
       Player p = gamePlay.get(0);
      if(p.paddleY < height - p.paddleLength - 5) {
        p.paddleY += p.paddleSpeed;
      }
    } 
    if(p1Up) {
      Player p = gamePlay.get(0);
      if(p.paddleY > 5) {
        p.paddleY -= p.paddleSpeed;
      }
    }
    if(p2Up) {
        Player p = gamePlay.get(1);
        if(p.paddleY > 5) {
          p.paddleY -= p.paddleSpeed;
      }
    }
    if(p2Down) {
        Player p = gamePlay.get(1);
        if(p.paddleY < height - p.paddleLength - 5) {
          p.paddleY += p.paddleSpeed;
        }
      }
    
    if(p3Left) {
      Player p = gamePlay.get(2);
      if(p.paddleX > 280 + 5) {
        p.paddleX -= p.paddleSpeed;
      }
    }
    if(p3Right) {
      Player p = gamePlay.get(2);
      if(p.paddleX < width - p.paddleLength - 5 - 280) {
        p.paddleX += p.paddleSpeed;
      }
    }
    if(p4Left) {
      Player p = gamePlay.get(3);
      if(p.paddleX > 5 + 280) {
        p.paddleX -= p.paddleSpeed;
      }
    }
    if(p4Right) {
      Player p = gamePlay.get(3);
      if(p.paddleX < width - p.paddleLength - 5 - 280) {
        p.paddleX += p.paddleSpeed;
      }
    }
  }
}

public void drawMultiPlayerMenu() {
  background(0);
  fill(255);
  textSize(50);
  String text = "MULTIPLAYER";
  text(text, width/2 - textWidth(text) / 2.0, 100);
  
  boolean hovering = false;
  hover = -1;
  
  if(mouseX > 220 && mouseX < 520 && mouseY > 180 && mouseY < 280) {
    hovering = true;
    hover = 0;
    cursor(HAND);
  }
 
  if(mouseX > 220 && mouseX < 520 && mouseY > 300 && mouseY < 400) {
    hovering = true;
    hover = 1;
    cursor(HAND);
  }
  
  strokeWeight(4);
  if(!(hover == 0 || numPlayers == 2)) {
    fill(0);
    stroke(255);
    rect(220, 180, 300, 100);
    fill(255);
  } else {
    fill(255);
    stroke(0);
    rect(220, 180, 300, 100);
    fill(0);
  }
  text("2 Player", 370 - textWidth("2 Player") / 2.0, 250);
  
  if(!(hover == 1 || numPlayers == 4)) {
    fill(0);
    stroke(255);
    rect(220, 300, 300, 100);
    fill(255);
  } else {
    fill(255);
    stroke(0);
    rect(220, 300, 300, 100);
    fill(0);
  }
  text("4 Player", 370 - textWidth("4 Player") / 2.0, 370);
  
  if(mouseX > 220 + 540 && mouseX < 520 + 540 && mouseY > 180 && mouseY < 280) {
    hovering = true;
    hover = 2;
    cursor(HAND);
  }
 
  if(mouseX > 220 + 540 && mouseX < 520 + 540 && mouseY > 300 && mouseY < 400) {
    hovering = true;
    hover = 3;
    cursor(HAND);
  }
  
  if(!(hover == 2 || numAI == 0)) {
    fill(0);
    stroke(255);
    rect(100 + 120 + 540, 180, 300, 100);
    fill(255);
  } else {
    fill(255);
    stroke(0);
    rect(100 + 120 + 540, 180, 300, 100);
    fill(0);
  }
  text("0 A.I.", 370 + 540 - textWidth("0 A.I.") / 2.0, 250);
  
  if(!(hover == 3 || numAI == 2)) {
    fill(0);
    stroke(255);
    rect(220 + 540, 300, 300, 100);
    fill(255);
  } else {
    fill(255);
    stroke(0);
    rect(220 + 540, 300, 300, 100);
    fill(0);
  }
  text("2 A.I.", 370 + 540 - textWidth("2 A.I.") / 2.0, 370);
  
  if(players.size() < numPlayers) {
    players.add(new Player());
  }
  
  while(players.size() > numPlayers) {
    players.remove(players.size() - 1);
  }
  
  for(int i = 0; i < players.size(); i ++) {
    Player p = players.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    stroke(255);
    rect(100 + 1.5*270/4.0 + i * 270, 630, 270/4.0, 270/4.0);
    if(p.paddleType == 0) {
      // Square Paddle
      rect(270 * i + 100 + (270 - p.paddleLength)/2.0, 550, p.paddleLength, p.paddleHeight);
    } else if(p.paddleType == 1) {
      // Rounded Paddle
      rect(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      ellipse(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
      ellipse(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
    } else if(p.paddleType == 2) {
      // Spiky Paddle
      rect(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      triangle(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, 270 * i + 100 + 
        (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight, 270 * i + 100 +
        (270 - p.paddleLength)/2.0, 550 + p.paddleHeight/2.0);
      triangle(270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550, 270 * i + 100 + (270 - p.paddleLength)/2.0  + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight, 270 * i + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength, 550 + p.paddleHeight/2.0);
    }
    
    text("Player" + (i + 1), 100 + (i * 270) + 270 / 2.0 - textWidth("Player" + (i + 1)) / 2.0, 500);
    
    stroke(255);
    if(mouseX > 120 + (i * 270) && mouseX < 160 + (i * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle((i * 270) + 130, 550 + 20/2.0, (i * 270) + 150, 550 - 5, (i * 270) + 150, 550 + 20 + 5);
    if(mouseX > 310 + (i * 270) && mouseX < 350 + (i * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(100 + (i * 270) + 270 - 30, 550 + 20/2.0, 100 + (i * 270) + 270 - 50, 550 - 5, 100 + (i * 270) + 270 - 50, 550 + 20 + 5);
    
    stroke(255);
    if(mouseX > i * 270 + 150 && mouseX < i * 270 + 190 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(i * 270 + 160, 652 + 20/2.0, i * 270 + 180, 652 - 5, i * 270 + 180, 652 + 20 + 5);
    
    if(mouseX > i * 270 + 100 + 180 && mouseX < i * 270 + 100 + 220 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(i * 270 + 100 + 270 - 60, 652 + 20/2.0, i * 270 + 100 + 270 - 80, 652 - 5, i * 270 + 100 + 270 - 80, 652 + 20 + 5);
    
  }
  
  for(int i = AI.size(); i < numAI; i ++) {
    AI.add(new Player());
  }
  
  while(AI.size() > numAI) {
    AI.remove(AI.size() - 1);
  }
  
  for(int i = 0; i < AI.size(); i ++) {
    Player p = AI.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    stroke(255);
    rect(100 + 1.5*270/4.0 + (i + players.size()) * 270, 630, 270/4.0, 270/4.0);
    if(p.paddleType == 0) {
      // Square Paddle
      rect(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0, 550, p.paddleLength, p.paddleHeight);
    } else if(p.paddleType == 1) {
      // Rounded Paddle
      rect(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      ellipse(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
      ellipse(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
    } else if(p.paddleType == 2) {
      // Spiky Paddle
      rect(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      triangle(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, 270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight, 270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0, 550 + p.paddleHeight/2.0);
      triangle(270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550, 270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0  + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight, 270 * (i+players.size()) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength, 550 + p.paddleHeight/2.0);
    }
    
    text("A.I.", 100 + ((i+players.size()) * 270) + 270 / 2.0 - textWidth("A.I.") / 2.0, 500);
    
    stroke(255);
    if(mouseX > 120 + ((i+players.size()) * 270) && mouseX < 160 + ((i+players.size()) * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2 + players.size()) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(((i+players.size()) * 270) + 130, 550 + 20/2.0, ((i+players.size()) * 270) + 150, 550 - 5, ((i+players.size()) * 270) + 150, 550 + 20 + 5);
    if(mouseX > 310 + ((i+players.size()) * 270) && mouseX < 350 + ((i+players.size()) * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2 + players.size()) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(100 + ((i+players.size()) * 270) + 270 - 30, 550 + 20/2.0, 100 + ((i+players.size()) * 270) + 270 - 50, 550 - 5, 100 + ((i+players.size()) * 270) + 270 - 50, 550 + 20 + 5);
    
    stroke(255);
    if(mouseX > (i+players.size()) * 270 + 150 && mouseX < (i+players.size()) * 270 + 190 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6 + players.size()) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle((i+players.size()) * 270 + 160, 652 + 20/2.0, (i+players.size()) * 270 + 180, 652 - 5, (i+players.size()) * 270 + 180, 652 + 20 + 5);
    
    if(mouseX > (i+players.size()) * 270 + 100 + 180 && mouseX < (i+players.size()) * 270 + 100 + 220 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6 + players.size()) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle((i+players.size()) * 270 + 100 + 270 - 60, 652 + 20/2.0, (i+players.size()) * 270 + 100 + 270 - 80, 652 - 5, (i+players.size()) * 270 + 100 + 270 - 80, 652 + 20 + 5);
    
  }
  
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 100;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
  rect(10, 10, 200, 75);
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);
    }
  text("BACK", 10 + 100 - textWidth("BACK")/2.0, 65);
  
  if(numAI + numPlayers >= 2) {
    if(mouseX < width - 10 && mouseX > width - 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 101;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    rect(width - 210, 10, 200, 75);
    if(mouseX < width - 10 && mouseX > width - 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);  
    }
    text("START", width - 10 - 100 - textWidth("START")/2.0, 65);
  }
    
  if(!hovering) {
    hover = -1;
    cursor(ARROW);
  }
}

public void drawSinglePlayerMenu() {
  background(0);
  fill(255);
  textSize(50);
  String text = "SINGLEPLAYER";
  text(text, width/2 - textWidth(text) / 2.0, 100);
  
  boolean hovering = false;
  hover = -1;
  
  if(mouseX > 100 && mouseX < 400 && mouseY > 180 && mouseY < 280) {
    hovering = true;
    hover = 0;
    cursor(HAND);
  }
 
  if(mouseX > 100 && mouseX < 400 && mouseY > 300 && mouseY < 400) {
    hovering = true;
    hover = 1;
    cursor(HAND);
  }
  
  strokeWeight(4);
  if(!(hover == 0 || numAI == 1)) {
    fill(0);
    stroke(255);
    rect(100, 180, 300, 100);
    fill(255);
    text("2 Player", 250 - textWidth("2 Player") / 2.0, 250);
  } else {
    fill(255);
    stroke(0);
    rect(100, 180, 300, 100);
    fill(0);
    text("2 Player", 250 - textWidth("2 Player") / 2.0, 250);
  }
  
  if(!(hover == 1 || numAI == 3)) {
    fill(0);
    stroke(255);
    rect(100, 300, 300, 100);
    fill(255);
  text("4 Player", 250 - textWidth("4 Player") / 2.0, 370);
  } else {
    fill(255);
    stroke(0);
    rect(100, 300, 300, 100);
    fill(0);
    text("4 Player", 250 - textWidth("4 Player") / 2.0, 370);
  }
  
  if(players.size() < numPlayers) {
    players.add(new Player());
  }
  
  while(players.size() > numPlayers) {
    players.remove(players.size() - 1);
  }
  
  //Test border code
  //text = "Player";
  //for(int i = 0; i < 4; i ++) {
  //  if(i != 0) {
  //    text = "A.I";
  //  } else {
  //    text = "Player";
  //  }
  //stroke(255);
  //  fill(0);
  //  rect(100 + (i * 270), 450, 270, 270);
  //  fill(255);
  //  text(text, 100 + (i * 270) + 270 / 2.0 - textWidth(text) / 2.0, 500);
  //}
  
  for(int i = 0; i < players.size(); i ++) {
    Player p = players.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    stroke(255);
    rect(100 + 1.5*270/4.0, 630, 270/4.0, 270/4.0);
    if(p.paddleType == 0) {
      // Square Paddle
      rect(100 + (270 - p.paddleLength)/2.0, 550, p.paddleLength, p.paddleHeight);
    } else if(p.paddleType == 1) {
      // Rounded Paddle
      rect(100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      ellipse(100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
      ellipse(100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
    } else if(p.paddleType == 2) {
      // Spiky Paddle
      rect(100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      triangle(100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight, 100 + (270 - p.paddleLength)/2.0, 550 + p.paddleHeight/2.0);
      triangle(100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550, 100 + (270 - p.paddleLength)/2.0  + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight, 100 + (270 - p.paddleLength)/2.0 + p.paddleLength, 550 + p.paddleHeight/2.0);
    }
    
    text("Player", 100 + (i * 270) + 270 / 2.0 - textWidth("Player") / 2.0, 500);
    
    stroke(255);
    if(mouseX > 120 && mouseX < 160 && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(130, 550 + 20/2.0, 150, 550 - 5, 150, 550 + 20 + 5);
    if(mouseX > 310 && mouseX < 350 && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = 3;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(100 + 270 - 30, 550 + 20/2.0, 100 + 270 - 50, 550 - 5, 100 + 270 - 50, 550 + 20 + 5);
    
    stroke(255);
    if(mouseX > 150 && mouseX < 190 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = 10;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(160, 652 + 20/2.0, 180, 652 - 5, 180, 652 + 20 + 5);
    
    if(mouseX > 280 && mouseX < 320 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = 11;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(100 + 270 - 60, 652 + 20/2.0, 100 + 270 - 80, 652 - 5, 100 + 270 - 80, 652 + 20 + 5);
    
  }
  
  for(int i = AI.size(); i < numAI; i ++) {
    AI.add(new Player());
  }
  
  while(AI.size() > numAI) {
    AI.remove(AI.size() - 1);
  }
  
  for(int i = 0; i < AI.size(); i ++) {
    Player p = AI.get(i);
    fill(p.playerRed, p.playerGreen, p.playerBlue);
    stroke(255);
    rect(100 + 1.5*270/4.0 + (i + players.size()) * 270, 630, 270/4.0, 270/4.0);
    if(p.paddleType == 0) {
      // Square Paddle
      rect(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0, 550, p.paddleLength, p.paddleHeight);
    } else if(p.paddleType == 1) {
      // Rounded Paddle
      rect(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      ellipse(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
      ellipse(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight/2.0, p.paddleHeight * 2, p.paddleHeight);
    } else if(p.paddleType == 2) {
      // Spiky Paddle
      rect(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, p.paddleLength - 2*p.paddleHeight, p.paddleHeight);
      triangle(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550, 270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleHeight, 550 + p.paddleHeight, 270 * (i+1) + 100 + (270 - p.paddleLength)/2.0, 550 + p.paddleHeight/2.0);
      triangle(270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength - p.paddleHeight, 550, 270 * (i+1) + 100 + (270 - p.paddleLength)/2.0  + p.paddleLength - p.paddleHeight, 550 + p.paddleHeight, 270 * (i+1) + 100 + (270 - p.paddleLength)/2.0 + p.paddleLength, 550 + p.paddleHeight/2.0);
    }
    
    text("A.I.", 100 + ((i+1) * 270) + 270 / 2.0 - textWidth("A.I.") / 2.0, 500);
    
    stroke(255);
    if(mouseX > 120 + ((i+1) * 270) && mouseX < 160 + ((i+1) * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(((i+1) * 270) + 130, 550 + 20/2.0, ((i+1) * 270) + 150, 550 - 5, ((i+1) * 270) + 150, 550 + 20 + 5);
    if(mouseX > 310 + ((i+1) * 270) && mouseX < 350 + ((i+1) * 270) && mouseY > 535 && mouseY < 585) {
      hovering = true;
      hover = (i + 2) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle(100 + ((i+1) * 270) + 270 - 30, 550 + 20/2.0, 100 + ((i+1) * 270) + 270 - 50, 550 - 5, 100 + ((i+1) * 270) + 270 - 50, 550 + 20 + 5);
    
    stroke(255);
    if(mouseX > (i+1) * 270 + 150 && mouseX < (i+1) * 270 + 190 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6) * 2;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle((i+1) * 270 + 160, 652 + 20/2.0, (i+1) * 270 + 180, 652 - 5, (i+1) * 270 + 180, 652 + 20 + 5);
    
    if(mouseX > (i+1) * 270 + 100 + 180 && mouseX < (i+1) * 270 + 100 + 220 && mouseY > 642 && mouseY < 682) {
      hovering = true;
      hover = (i + 6) * 2 + 1;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    triangle((i+1) * 270 + 100 + 270 - 60, 652 + 20/2.0, (i+1) * 270 + 100 + 270 - 80, 652 - 5, (i+1) * 270 + 100 + 270 - 80, 652 + 20 + 5);
    
  }
  
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 18;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
  rect(10, 10, 200, 75);
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);
    }
  text("BACK", 10 + 100 - textWidth("BACK")/2.0, 65);
  
  // fill(0);
  //stroke(255);
  //rect(500, 180, 600, 220);
  // // DISPLAY CASE
  
  Player p = players.get(0);
  fill(p.playerRed, p.playerGreen, p.playerBlue);
  stroke(255);
  rect(100 + 1.5*270/4.0, 630, 270/4.0, 270/4.0);
  if(p.paddleType == 0) {
    // Square Paddle
    rect(500 + 300 - p.paddleLength * 1.8 / 2, 200, p.paddleLength * 1.8, p.paddleHeight* 1.8);
  } else if(p.paddleType == 1) {
    // Rounded Paddle
    rect(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8, 200, p.paddleLength*1.8 - 2*p.paddleHeight*1.8, p.paddleHeight*1.8);
    ellipse(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8, 200 + p.paddleHeight*1.8/2.0, p.paddleHeight*1.8 * 2, p.paddleHeight*1.8);
    ellipse(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8 + p.paddleLength*1.8 - 2*p.paddleHeight*1.8, 200 + p.paddleHeight*1.8/2.0, p.paddleHeight*1.8 * 2, p.paddleHeight*1.8);
  } else if(p.paddleType == 2) {
    // Spiky Paddle
    rect(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8, 200, p.paddleLength*1.8 - 2*p.paddleHeight*1.8, p.paddleHeight*1.8);
    triangle(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8 + p.paddleHeight*1.8 + p.paddleLength*1.8 - 2*p.paddleHeight*1.8, 200 + p.paddleHeight*1.8/2.0, 500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8 + p.paddleLength*1.8 - 2*p.paddleHeight*1.8, 200, 500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8 + p.paddleLength*1.8 - 2*p.paddleHeight*1.8, 200 + p.paddleHeight*1.8);
    triangle(500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8 - p.paddleHeight*1.8, 200 + p.paddleHeight*1.8/2.0, 500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8, 200, 500 + 300 - p.paddleLength * 1.8 / 2 + p.paddleHeight * 1.8, 200 + p.paddleHeight*1.8);
  }
  
  fill(255);
  text("SPEED", 500 + 300 - p.paddleLength * 1.8 / 2 - textWidth("SPEED"), 300);
  text("POWER", 500 + 300 + p.paddleLength * 1.8 / 2, 300);
  
  fill(0);
  stroke(255);
  rect(500 + 300 - p.paddleLength * 1.8 / 2 - 160, 315, 160, 60);
  rect(500 + 300 + p.paddleLength * 1.8 / 2, 315, 160, 60);
  
  float speedMult = 1.0;
  float powerMult = 1.0;
  
  if(p.paddleType == 0) {
    speedMult = 0.75;
    powerMult = 0.75;
  } else if(p.paddleType == 1) {
    speedMult = 0.5;
    powerMult = 1;
  } else if(p.paddleType == 2) {
    speedMult = 1;
    powerMult = .5;
  }
  
  fill(0, 255, 0);
  rect(500 + 300 - p.paddleLength * 1.8 / 2 - 160, 315, 160 * speedMult, 60);
  rect(500 + 300 + p.paddleLength * 1.8 / 2, 315, 160 * powerMult, 60);
  
  if(numAI + numPlayers >= 2) {
    if(mouseX < width - 10 && mouseX > width - 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 19;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    rect(width - 210, 10, 200, 75);
    if(mouseX < width - 10 && mouseX > width - 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);  
    }
    text("START", width - 10 - 100 - textWidth("START")/2.0, 65);
  }
    
  if(!hovering) {
    hover = -1;
    cursor(ARROW);
  }
}

public void drawMenu() {
  background(0);
  fill(255);
  textSize(50);
  String text = "PONG";
  text(text, width/2 - textWidth(text) / 2.0, 100);
  boolean hovering = false;
  hover = -1;
  
  for(int i = 0; i < 3; i ++) {
    if(mouseX > width/2 - 400/2.0 && mouseX < width/2 - 400/2.0 + 400
    && mouseY > 200 + (i * 150) && mouseY < 200 + (i * 150) + 100) {
      hover = i;
      hovering = true;
    }
    
    if(hover == i) {
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
    
    strokeWeight(4);
    rect(width/2 - 400/2.0, 200 + i*(150), 400, 100);
    
    if(hover == i) {
      fill(0);
    } else {
      fill(255);
    }
    
    if(i == 0) {
      text = "SINGLEPLAYER";
    } else if(i == 1) {
      text = "MULTIPLAYER";
    } else if(i == 2) {
      text = "OPTIONS";
    }
    text(text, width/2 - textWidth(text) / 2.0, 268 + (i * 150));
  }
  
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      hovering = true;
      hover = 18;
      cursor(HAND);
      fill(255);
      stroke(0);
    } else {
      fill(0);
      stroke(255);
    }
  rect(10, 10, 200, 75);
  if(mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 85) {
      fill(0);
    } else {
      fill(255);
    }
  text("EXIT", 10 + 100 - textWidth("EXIT")/2.0, 65);
  
  if(!hovering) {
    hover = -1;
    cursor(ARROW);
  } else {
    cursor(HAND);
  }
}

class Player {
  int paddleType, playerRed, playerGreen, playerBlue, paddleLength, paddleHeight, paddleX, paddleY, paddleSpeed, paddleStr;
  public Player() {
    paddleType = (int) (Math.random() * 3);
    playerRed = (int) (Math.random() * 256);
    playerGreen = (int) (Math.random() * 256);
    playerBlue = (int) (Math.random() * 256);
    paddleLength = 135;
    paddleHeight = 20;
  }
}

class Ball {
  public int diameter;
  public float xSpeed;
  public float ySpeed;
  public float xLoc;
  public float yLoc;
  public float tween = 0;
  public boolean tweenAllow = true;
  public int player;
  
  public Ball(int player) {
    this.player = player;
    this.diameter = 24;
    if(player == 0) {
      xLoc = 200;
      yLoc = height/2;
      xSpeed = -2;
      ySpeed = 0;
    } else if(player == 1) {
      xLoc = width - 200;
      yLoc = height/2;
      xSpeed = 2;
      ySpeed = 0;
    } else if(player == 2) {
      yLoc = 300;
      xLoc = width/2;
      xSpeed = 0;
      ySpeed = -2;
    } else if(player == 3) {
      yLoc = height - 300;
      xLoc = width/2;
      xSpeed = 0;
      ySpeed = 2;
    }
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

public void collide3(Ball b1, Ball b2) {
  // With Ball1 the center, angle of distortion from normal X acis to perpendicular contact
  double xDiff = b2.xLoc - b1.xLoc;
  double yDiff = b2.yLoc - b1.yLoc;
  
  //println(xDiff + " " + yDiff);
  //println(Math.toDegrees(Math.atan(yDiff/xDiff)));
  //println(Math.toDegrees(Math.atan(-xDiff/yDiff)));
  
  //println("COLLIDED " + b1.xLoc + "," + b1.yLoc + " | " + b2.xLoc + "," + b2.yLoc);
  
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
  
  if(FORCEDIFFX == 0 && FORCEDIFFY == 0) {
    if(b1.xSpeed > b1.ySpeed) {
      FORCEDIFFX = 1;
    } else {
      FORCEDIFFY = 1;
    }
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
  
    if(FORCEDIFFX == 0 && FORCEDIFFY == 0) {
    if(b2.xSpeed > b2.ySpeed) {
      FORCEDIFFX = 5;
    } else {
      FORCEDIFFY = 5;
    }
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

  b1.tween = b1.diameter / 3.0;
  b2.tween = b2.diameter / 3.0;
   
  //run = false;
 
}
