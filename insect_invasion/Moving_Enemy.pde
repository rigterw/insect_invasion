class MovingEnemy extends MainEnemy {

  MovingEnemy(int xspeed, int yspeed, int circleX, int circleY, boolean isEnabled, int level) {
    this.xspeed = xspeed;
    this.yspeed = yspeed;
    this.circleX = circleX;
    this.circleY = circleY;
    this.isEnabled = isEnabled;
    this.level = level;
  }


  void draw() {

    super.draw();//inherits everything inside the draw of all enemy classes

    circleX = circleX + xspeed;//moving enemy
    circleY = circleY + yspeed;

    if (level == 1) {

      if (circleX == 339 && circleY >= 497) {//big loop for moving enemy level 1
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
      } else if (circleX >= 570 && circleY >= 497) {
        xspeed = 3;
        yspeed = 0;
      }
    } else if (level == 2) {//clockwise movement enemy level 2
      if (circleX == 979 && circleY == 380) {
        xspeed = 0;
        yspeed = 3;
        println("hoek 2");
      } else if (circleX == 979 && circleY == 620) {
        xspeed = -3; 
        yspeed = 0;
        println("hoek 3");
        println(circleX+ "= X");
      } else if (circleX == 700 && circleY == 620) {
        println(circleX+ "= X");
        println("hoek 4");
        xspeed = 0;
        yspeed = -3;
      }
      //} else if (level == 2) {//clockwise movement enemy level 2


      //if (circleX == 340 && circleY == 380) {
      //  xspeed = 3;
      //  yspeed = 0;
      //} else if (circleX == 700 && circleY == 380) {
      //  xspeed = 0;
      //  yspeed = 3;
      //} else if (circleX == 700 && circleY == 620) {
      //  xspeed = -3;
      //  yspeed = 0;
      //} else if (circleX == 619 && circleY == 620) {
      //  xspeed = 0;
      //  yspeed = 3;
      //} else if (circleX == 619 && circleY == 662) {
      //  xspeed = -2;
      //  yspeed = 0;
      //} else if (circleX == 459 && circleY == 662) {
      //  xspeed = 0;
      //  yspeed = -3;
      //  //println(circleX + "= 3X");
      //  //println(circleY + "= 3Y");
      //} else if (circleX == 459 && circleY == 623) {
      //  xspeed = -3;
      //  yspeed = 0;
      //} else if (circleX == 219 && circleY == 623) {
      //  println(circleX + "= 3X");
      //  println(circleY + "= 3Y");
      //  xspeed = 0;
      //  yspeed = -3;
      //} else if (circleX == 700 && circleY == 380) {
      //  xspeed = -3;
      //  yspeed = 0;
      //} else if (circleX == 340 && circleY == 59) {
      //  xspeed = 3;
      //  yspeed = 0;
      //} else if (circleX == 700 && circleY == 59) {  
      //  xspeed = 0;
      //  yspeed = 3;
      //} else if (circleX == 700 && circleY == 380) {
      //  xspeed = -3;
      //  yspeed = 0;
      //} else if (circleX == 340 && circleY == 380) {
      //  xspeed = -3;
      //  yspeed = 0;
      //}
    }
  }
}
