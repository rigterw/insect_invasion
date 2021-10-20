class StaticEnemy extends MainEnemy {

  StaticEnemy() {
    circleX = 739; //start position x enemy
    circleY = 20; //start position y enemy
  }

  void draw() {
    noStroke(); //enemy vision circle
    fill(0);
    //noFill();
    ellipse(circleX, circleY, diameter+138, diameter+248);

    if(p.x >= diameter+648 && p.x <= diameter+758 && p.y >= diameter+87 && p.y <= diameter+126){
      circleY = 60;
      //println("watch out!");
    } else {
      circleY = 20;
      //println("fine"); 
    }
    
    //println(mouseX + " : " + mouseY);
    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
