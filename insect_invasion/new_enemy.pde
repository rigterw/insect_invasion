//class Enemy{
//  int circleX;
//  int circleY;
//  int circleW = 32;
//  int circleH = 32;
//  int yspeed = 0;
//  int xspeed = 0;

//void update(){
//   circleX = 339; //start position x enemy
//   circleY = 220; //start position y enemy
//}


//void draw(){
//  noStroke(); //enemy vision circle
//  noFill();
//  ellipse(circleX, circleY, 120, 120);
  
//  if (p.x <= circleX){}
//  stroke(2);
//  fill(255, 0, 0); //enemy circle
//  ellipse(circleX, circleY, circleW, circleH);
  
//  circleX = circleX + xspeed;
//  circleY = circleY + yspeed;
  
  
//  if (circleX >= 817 && circleY == 220){
//    xspeed = 0;
//    yspeed = 4;
//  }else if (circleX >= 817 && circleY >= 497){
//    xspeed = -4;
//    yspeed = 0;
//  }else if (circleX <= 342 && circleY >= 497){
//    xspeed = 0;
//    yspeed = -4;
//  }else if (circleX <= 342 && circleY == 220){
//    xspeed = 4;
//    yspeed = 0;
//  }
  
//}
//}

class Enemy{
  int circleX;
  int circleY;
  int yspeed = 4;
  int xspeed = 0;

void update(){
   circleX = 339; //start position x enemy
   circleY = 220; //start position y enemy
}


void draw(){
 
  fill(255, 0, 0);
  ellipse(circleX, circleY, 32, 32);
  
  circleX = circleX + xspeed;
  circleY = circleY + yspeed;
  
  
  if (circleX == 339 && circleY >= 497){
    xspeed = 4;
    yspeed = 0;
  }else if (circleX >= 817 && circleY >= 497){
    xspeed = 0;
    yspeed = -4;
  }else if (circleX >= 817 && circleY <= 220){
    xspeed = -4;
    yspeed = 0;
  }else if (circleX <= 339 && circleY <= 220){
    xspeed = 0;
    yspeed = 4;
  }
  
}
}
