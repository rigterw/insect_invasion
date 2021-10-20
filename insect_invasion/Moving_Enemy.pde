class MovingEnemy extends MainEnemy {

  MovingEnemy() {
    xspeed = 0;//starting speed in x direction
    yspeed = 3;//starting speed in y direction
    circleX = 339; //start position x enemy
    circleY = 220; //start position y enemy
  }


  void draw() {

    super.draw();//inherits everything inside the draw of all enemy classes
    circleX = circleX + xspeed;//moving enemy
    circleY = circleY + yspeed;
    
    if (circleX == 339 && circleY >= 497) {//big loop for moving enemy
      xspeed = 3;
      yspeed = 0;
    } else if (circleX >= 817 && circleY >= 497) {
      xspeed = 0;
      yspeed = -3;
    } else if (circleX >= 817 && circleY <= 220) {
      xspeed = -3;
      yspeed = 0;
    } else if (circleX <= 339 && circleY <= 220) {
      xspeed = 0;
      yspeed = 3;
    }
  }
}
