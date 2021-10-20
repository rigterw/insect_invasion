class Player
{
  float x, y, w, h;
  float speedX, speedY, maxSpeed;
  float radius;
  float distance;
  int score;

  Player()
  {
    //x = 400;
    //y = 145;
    x = width/2;
    y = height/2;
    w = 24;
    h = 24;
    maxSpeed = 2;
    speedX = 0;
    speedY = 0;
    radius = w / 2;
    score = 0;
  }

  void update()
  {
    if (left == true)    // horizontaal bewegen
    {
      // speedY = 0;     ////////* uitgezet zodat de lateral movement werkt
      speedX = -maxSpeed;
    }

    if (right == true)
    {
      // speedY = 0;     ///////*
      speedX = maxSpeed;
    }

    if ((left == false && right == false) || (left == true && right == true))
    {
      speedX = 0;
    }


    if (up == true)        // verticaal bewegen
    {
      // speedX = 0;       ////////*
      speedY = -maxSpeed;
    }

    if (down == true) 
    {
      // speedX = 0;       ////////*
      speedY = maxSpeed;
    }

    if ((up == false && down == false) || (up == true && down == true))
    {
      speedY = 0;
    }

    y += speedY;        // positie updaten
    x += speedX;
    
    distance = radius + coin1.coinRadius;  //Voor collision tussen de player en coin.

    //de distance moet kleiner zijn (dus in elkaar) én de coin moet enabled zijn.
    if (dist(x, y, coin1.x, coin1.y) < distance) {
      if (coin1.isEnabled == true) {
        coin1.pickUp(); 
        println("coin picked up");
        score +=1; //score van de player gaat omhoog als de coin wordt opgepakt.
        println("score = " + score);  
      }
    }    
  }

  void display()
  {
    fill(100, 100, 220);
    ellipse(x, y, w, h);
    image(Player, x - (w / 2), y - (h / 2), w, h);
  }
}
