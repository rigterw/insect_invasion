class MainEnemy {
  int circleX, circleY, xspeed, yspeed, diameter;

  MainEnemy() {
    diameter = 32;
  }
  
void draw() {
  //noStroke(); //enemy vision circle
  //fill(0);
  ////noFill();
  //ellipse(circleX, circleY, 120, 120);
  
  fill(255, 0, 0); //enemy
  ellipse(circleX, circleY, diameter, diameter);
}
}
