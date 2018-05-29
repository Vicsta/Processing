int x1, y1, y2, x3;
int x2 = 600;
int y3 = 600;
int x4 = 600;
int y4 = 600;

int i = 0;
int j = 0;
int k = 200;

int dist = 0;

int s = 0;
int t = 0;
int u = 0;

boolean run = true;

void setup() {
  size(700,700);
  background();
}

void background() {
  background(255, 255, 255);  
}

void pastSquares (int x) {
  background();
  i = 0;
  x2 = y3 = x4 = y4 = 600;
  x1 = y1 = y2 = x3 = 0;
  while(i <= 255) {
      stroke(i, i, i);
      fill(255, 255, 255);
      rect(x1, y1 - x, 100 + x, 100 + x);
      rect(x2 - x, y2, 100 + x, 100 + x);
      rect(x3, y3 - x, 100 + x, 100 + x);
      rect(x4 - x, y4, 100 + x, 100 + x);
      x1++;
      y1++;
      y2++;
      x2--;
      x3++;
      y3--;
      x4--;
      y4--;
      i++;
    }
}

void mousePressed(){
  run = !run;
}

void draw(){
  if(run) {
    if(i <= 255) {
      rect(x1, y1, 100, 100);
      rect(x2, y2, 100, 100);
      rect(x3, y3, 100, 100);
      rect(x4, y4, 100, 100);
      stroke(i, i, i);
      x1++;
      y1++;
      y2++;
      x2--;
      x3++;
      y3--;
      x4--;
      y4--;
      i++;
    } else {
      if(j <= 200) {
        stroke(0, 0, 0);
        ellipse(350, 350, j, j);
        j++;
      } else {
        if(dist <= 350) {
          pastSquares(0);
          stroke((float) (Math.random() * 255), (float) (Math.random() * 255), (float) (Math.random() * 255));
          ellipse(350 + dist, 350, j, j);
          ellipse(350 - dist, 350, j, j);
          ellipse(350, 350 + dist, j, j);
          ellipse(350, 350 - dist, j, j);
          dist++;
        } else {
          if(k > 0) {
            pastSquares(0);
            stroke((float) (Math.random() * 255), (float) (Math.random() * 255), (float) (Math.random() * 255));
            fill((float) (255 - (200 - k)), (float) (255 - (200 - k)), (float) (255));
            ellipse(350 + dist, 350, k, k);
            ellipse(350 - dist, 350, k, k);
            ellipse(350, 350 + dist, k, k);
            ellipse(350, 350 - dist, k, k);
            k--;
          } else {
            if(s < 100) {
              s++;
              pastSquares(s);
            } else {
              if(t < 100) {
                if(t == 99) {
                  stroke(255, 255, 0);
                } else {
                  stroke((float) (Math.random() * 255), (float) (Math.random() * 255), (float) (Math.random() * 255));
                }
                ellipse(350, 350, t, t);
                t++;
              } else {
                if(u < 100) {
                  if(u == 99) {
                    stroke(0, 255, 0);
                  } else {
                    stroke((float) (Math.random() * 255), (float) (Math.random() * 255), (float) (Math.random() * 255));
                  }
                  ellipse(350, 225, u, u);
                  if(u == 99) {
                    stroke(255, 0, 0);
                  }
                  ellipse(350, 475, u, u);
                  u++;
                }
              }
            }
          }
        }
      }
    }
  }
}
