/* 
 * @Author Victor Treaba
 * A simple processing program that acts like
 * a simple paint program.
 */
 
int tab = 0;
// Tab 0 = Shape, Tab 1 = Size, Tab 2 = Color

int frame = 0;
/* Index of selected frame on tab, also used as shape code
 *
 * 0 - Line tool
 * 1 - Circle
 * 2 - Triangle
 * 3 - Square
 * 4 - Up Down Oval
 * 5 - Left Right Oval
 * 6 - Up Down Rect
 * 7 - fLeft Right Rect
 */

int numFrames = 0;
// Number of frames in current tab

int curSize = 20;
// Size of brush

// Location of size slider
int sliderX = 500;
boolean sliderSelected = false;

// Location of fill sliders
int sliderRedX = 275;
int sliderGreenX = 577;
int sliderBlueX = 875;

boolean slider1 = false;
boolean slider2 = false;
boolean slider3 = false;

// Value of fill sliders
int red = 255;
int green = 255;
int blue = 255;

// Boolean for if we are selecting the stroke color, versus the fill color
boolean strokeCol = false;

// Location of stroke sliders
int strRedX = 70;
int strGreenX = 370;
int strBlueX = 670;

// Value of stroke sliders
int redStr = 0;
int greenStr = 0;
int blueStr = 0;

void setup() {
  size(1300, 800);
  background(255, 255, 255);
  bar();
}

Double dist(int x1, int y1, int x2, int y2) {
  return Math.sqrt(Math.pow(x1 - x2,2) + Math.pow(y1 - y2, 2));
}

void mousePressed() {
  // If the mouse is clicked on the tabs, if clicked on Size or Shape tab, draw over the stroke and fill tabs shown in Color tab
  if(mouseX > 10 && mouseX < 130 && mouseY > 640 && mouseY < 700) {
    if(tab != 0) {
      tab = 0;
      fill(255, 255, 255);
      stroke(255, 255, 255);
      rect(400, 660, 100, 37);
      rect(510, 660, 100, 37);
      bar();
    }
  } else if(mouseX > 140 && mouseX < 260 && mouseY > 640 && mouseY < 700) {
    if(tab != 1) {
      tab = 1;
      fill(255, 255, 255);
      stroke(255, 255, 255);
      rect(400, 660, 100, 37);
      rect(510, 660, 100, 37);
      bar();
    }
  } else if(mouseX > 270 && mouseX < 390 && mouseY > 640 && mouseY < 700) {
    if(tab != 2) {
      tab = 2;
      bar();
    }
  // If mouse click is on the clear tab
  } else if(mouseX > 1170 && mouseX < 1290 && mouseY > 640 && mouseY < 700) {
    background(255, 255, 255);
  // If color tab is active and mouse click is on the Stroke tab or Fill tab
  } else if(tab == 2 && mouseX > 400 && mouseX < 500 && mouseY > 660 && mouseY < 700) {
    strokeCol = false;
  } else if(tab == 2 && mouseX > 510 && mouseX < 610 && mouseY > 660 && mouseY < 700) {
    strokeCol = true;
  } else if(mouseX > 0 && mouseX < 1300 && mouseY > 0 && mouseY < 700) {
  // If inside the drawing area
    paint();
  }
  
  // On shape tab, when a click is on one of the shape frames figure out which it is by looping through the number of frames
  for(int i = 0; i < numFrames; i ++) {
    if(tab == 0 && mouseX > 10 + (i * 10) + (i * 80) && mouseX < 10 + ((i + 1) * 80) + (i * 10) && mouseY > 710 && mouseY < 790) {
      frame = i;
    }
  }
  
  // If clicking on the slider on size page
  if(tab == 1 && mouseX > sliderX && mouseX < sliderX + 15 && mouseY > 730 && mouseY < 770) {
      sliderSelected = true;
  // If clicking on slider bar on the size page    
  } else if(tab == 1 && mouseX - 8 > 210 && mouseX - 8 < 1095 && mouseY > 735 && mouseY < 765) {
    sliderX = mouseX - 8;
  // Left endpoint of slider bar handling
  } else if(tab == 1 && mouseX - 8 < 210 && mouseX - 8 > 180 && mouseY > 735 && mouseY < 765) {
    sliderX = 210;
  // Right endpoint of slider bar handling
  } else if(tab == 1 && mouseX - 8 > 1095 && mouseX - 8 < 1120 && mouseY > 735 && mouseY < 765) {
    sliderX = 1095;
  }
  
  // If clicking on the sliders on Colors page, Fill tab
  if(!strokeCol && tab == 2 && dist(mouseX, mouseY, sliderRedX, 735) <= 30) {
    slider1 = true;
  } else if(!strokeCol && tab == 2 && dist(mouseX, mouseY, sliderGreenX, 735) <= 30) {
    slider2 = true;
  } else if(!strokeCol && tab == 2 && dist(mouseX, mouseY, sliderBlueX, 735) <= 30) {
    slider3 = true;
  // Clicking on sliders on Colors page, Stroke tab
  } else if(strokeCol && tab == 2 && dist(mouseX, mouseY, strRedX, 735) <= 30) {
    slider1 = true;
  } else if(strokeCol && tab == 2 && dist(mouseX, mouseY, strGreenX, 735) <= 30) {
    slider2 = true;
  } else if(strokeCol && tab == 2 && dist(mouseX, mouseY, strBlueX, 735) <= 30) {
    slider3 = true;
  }
}

void mouseDragged() {
  // Size slider currently selected, then drag it up to a certain bound
  if(sliderSelected) {
    if(mouseX - 8 > 210 && mouseX - 8 < 1095) {
      sliderX = mouseX - 8;
    } else if(mouseX - 8 < 210) {
      sliderX = 210;
    } else if(mouseX - 8 > 1095) {
      sliderX = 1095;
    }
  // If the color sliders are dragged, based on Fill or Stroke tab change their positions
  } else if(slider1) {
     if(mouseX > 70 && mouseX < 275) {
      if(!strokeCol) { 
        sliderRedX = mouseX;
      } else {
        strRedX = mouseX;
      }
    } else if(mouseX < 70) {
      if(!strokeCol) { 
        sliderRedX = 70;
      } else {
        strRedX = 70;
      }
    } else if(mouseX > 275) {
      if(!strokeCol) { 
        sliderRedX = 275;
      } else {
        strRedX = 275;
      }
    }
    if(!strokeCol) { 
      red = (int) ((sliderRedX - 70) * 1.248);
    } else {
      redStr = (int) ((strRedX - 70) * 1.248);
    }
  // Color slider 2
  } else if(slider2) {
    if(mouseX > 370 && mouseX < 575) {
      if(!strokeCol) { 
        sliderGreenX = mouseX;
      } else {
        strGreenX = mouseX;
      }
    } else if(mouseX < 370) {
      if(!strokeCol) { 
        sliderGreenX = 370;
      } else {
        strGreenX = 370;
      }
    } else if(mouseX > 575) {
      if(!strokeCol) { 
        sliderGreenX = 575;
      } else {
        strGreenX = 575;
      }
    }
    if(!strokeCol) { 
      green = (int) ((sliderGreenX - 370) * 1.248);
    } else {
      greenStr = (int) ((strGreenX - 370) * 1.248);
    }
  // Color slider 3
  } else if(slider3) {
    if(mouseX > 670 && mouseX < 875) {
      if(!strokeCol) { 
        sliderBlueX = mouseX;
      } else {
        strBlueX = mouseX;
      }
    } else if(mouseX < 670) {
      if(!strokeCol) { 
        sliderBlueX = 670;
      } else {
        strBlueX = 670;
      }
    } else if(mouseX > 875) {
      if(!strokeCol) { 
        sliderBlueX = 875;
      } else {
        strBlueX = 875;
      }
    }
    if(!strokeCol) { 
      blue = (int) ((sliderBlueX - 670) * 1.248);
    } else {
      blueStr = (int) ((strBlueX - 670) * 1.248);
    }
  }
  // If mouse is dragged on canvas, paint
  if(mouseX > 0 && mouseX < 1300 && mouseY > 0 && mouseY < 700) {
    paint();
  }
}

void mouseReleased() {
  // For safety just deselect all sliders
  sliderSelected = false;
  slider1 = false;
  slider2 = false;
  slider3 = false;
}

// Method in paint to redraw the bottom bar constantly
void bar() {
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(255, 255, 255);
    rect(-4, 700, 1308, 100);
    // Add a green highlight on the current tab, based on which tab is selected, then call that tab's paint method
    switch(tab) {
      case 0: {
        fill(211, 255, 211);
        rect(10, 640, 120, 60, 55, 5, 0, 0);
        fill(255, 255, 255);
        rect(140, 640, 120, 60, 5, 5, 0, 0);
        rect(270, 640, 120, 60, 5, 55, 0, 0);
        shapeTab();
        break;
      }
      case 1: {
        rect(10, 640, 120, 60, 55, 5, 0, 0);
        fill(211, 255, 211);
        rect(140, 640, 120, 60, 5, 5, 0, 0);
        fill(255, 255, 255);
        rect(270, 640, 120, 60, 5, 55, 0, 0);
        sizeTab();
        break;
      }
      case 2: {
        rect(10, 640, 120, 60, 55, 5, 0, 0);
        rect(140, 640, 120, 60, 5, 5, 0, 0);
        fill(211, 255, 211);
        rect(270, 640, 120, 60, 5, 55, 0, 0);
        fill(255, 255, 255);
        if(!strokeCol) {
          fill(211, 255, 211);
        }
        rect(400, 660, 100, 40);
        fill(255, 255, 255);
        if(strokeCol) {
          fill(211, 255, 211);
        }
        rect(510, 660, 100, 40);
        textSize(20);
        fill(0, 0, 0);
        text("Fill", 410, 685);
        text("Stroke", 520, 685);
        colorTab();
        break;
      }
  }
  // Add text to the tabs and a CLEAR tab
  strokeWeight(3);
  stroke(0, 0, 0);
  fill(255, 255, 255);
  rect(1170, 640, 120, 60, 55, 55, 0, 0);
  fill(0, 0, 0);
  textSize(32);
  text("Shape", 20, 680);
  text("Size", 150, 680);
  text("Color", 280, 680);
  text("CLEAR", 1180, 680);
}

void frames(int x) {
  // Paint frames on the screen, and paint the selected frame with a light green background
  numFrames = x;
  strokeWeight(2);
  int padding = 10;
  for(int i = 0; i < x; i ++) {
    if(i == frame) {
      fill(211, 255, 211);
    } else {
      fill(255, 255, 255);
    }
    rect(padding, 710, 80, 80, 5);
    padding += 80 + 10;
  }
}

// Shape tab draw method
void shapeTab() {
  frames(8);
  stroke(red, green, blue);
  fill(red, green, blue);
  ellipse(50, 750, 20, 20);
  stroke(redStr, greenStr, blueStr);
  ellipse(140, 750, 50, 50);
  triangle(230, 730, 210, 770, 250, 770);
  rect(295, 725, 50, 50);
  ellipse(410, 750, 25, 50);
  ellipse(500, 750, 50, 25);
  rect(577.5, 725, 25, 50);
  rect(655, 737.5, 50, 25);
}

// Size tab draw method
void sizeTab() {
  frames(0);
  fill(255, 255, 255);
  rect(200, 745, 920, 10, 5);
  textSize(32);
  fill(0, 0, 0);
  curSize = (sliderX - 210) / 15 + 1;
  text("Size: " + curSize, 30, 760);
  fill(255, 255, 255);
  strokeWeight(4);
  rect(sliderX, 730, 15, 40, 5);
}

// Color tab draw method
void colorTab() {
  frames(0);
  rect(45, 730, 255, 10, 5);
  rect(345, 730, 255, 10, 5);
  rect(645, 730, 255, 10, 5);
  textSize(30);
  fill(0, 0, 0);
  if(!strokeCol) {
    text("Red: " + red, 45, 780);
    text("Green: " + green, 345, 780);
    text("Blue: " + blue, 645, 780);
  } else {
    text("Red: " + redStr, 45, 780);
    text("Green: " + greenStr, 345, 780);
    text("Blue: " + blueStr, 645, 780);
  }
  fill(255, 255, 255);
  strokeWeight(4);
  if(!strokeCol) {
    fill(255, 255 - red, 255 - red);
    ellipse(sliderRedX, 735, 30, 30);
    fill(255 - green, 255, 255 - green);
    ellipse(sliderGreenX, 735, 30, 30);
    fill(255 - blue, 255 - blue, 255);
    ellipse(sliderBlueX, 735, 30, 30);
  } else {
    fill(255, 255 - redStr, 255 - redStr);
    ellipse(strRedX, 735, 30, 30);
    fill(255 - greenStr, 255, 255 - greenStr);
    ellipse(strGreenX, 735, 30, 30);
    fill(255 - blueStr, 255 - blueStr, 255);
    ellipse(strBlueX, 735, 30, 30);
  }
  strokeWeight(6);
  fill(red, green, blue);
  stroke(redStr, greenStr, blueStr);
  rect(950, 710, 300, 80, 30);
}

// Method to paint on the canvas the selected image, called on click or drag
void paint() {
  fill(red, green, blue);
  stroke(redStr, greenStr, blueStr);
  switch(frame) {
    case 0: {
      stroke(red, green, blue);
      ellipse(mouseX, mouseY, curSize, curSize);
      return;
    }
    case 1: {
      ellipse(mouseX, mouseY, curSize, curSize);
      return;
    }
    case 2: {
      triangle(mouseX, mouseY - curSize, mouseX - (float)Math.cos(Math.toRadians(30))*curSize, mouseY + 0.5*curSize, mouseX + (float)Math.cos(Math.toRadians(30))*curSize, mouseY + 0.5*curSize);
      return;
    }
    case 3: {
      rect(mouseX - curSize/2, mouseY - curSize/2, curSize, curSize);
      return;
    }
    case 4: {
      ellipse(mouseX, mouseY, curSize/2, curSize);
      return;
    }
    case 5: {
      ellipse(mouseX, mouseY, curSize, curSize/2);
      return;
    }
    case 6: {
      rect(mouseX - curSize/4, mouseY - curSize/2, curSize/2, curSize);
      return;
    }
    case 7: {
      rect(mouseX - curSize/2, mouseY - curSize/4, curSize, curSize/2);
      return;
    }
  }
}

void draw() {
  bar();
}
