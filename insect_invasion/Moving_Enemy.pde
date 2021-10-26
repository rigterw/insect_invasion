 class MovingEnemy extends MainEnemy {

  MovingEnemy(int xspeed, int yspeed, int circleX, int circleY) {
    this.xspeed = xspeed;
    this.yspeed = yspeed;
    this.circleX = circleX;
    this.circleY = circleY;
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
