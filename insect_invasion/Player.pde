class Player
{
  float x, y, w, h; //x en y positie van de speler, width en height van de speler
  float speedX, speedY, maxSpeed; //de snelheid waarmee de speler zich beweegt
  float radius; //radius van de speler voor de collisions
  float distance; //distance voor de collision met de coins
  int score; // integer voor het optellen van de score wanneer coins worden opgepakt

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
      // speedY = 0;     //* uitgezet zodat de lateral movement werkt
      speedX = -maxSpeed;
    }

    if (right == true)
    {
      // speedY = 0;     //*
      speedX = maxSpeed;
    }

    if ((left == false && right == false) || (left == true && right == true))
    {
      speedX = 0;
    }


    if (up == true)        // verticaal bewegen
    {
      // speedX = 0;       //*
      speedY = -maxSpeed;
    }

    if (down == true) 
    {
      // speedX = 0;       //*
      speedY = maxSpeed;
    }

    if ((up == false && down == false) || (up == true && down == true))
    {
      speedY = 0;
    }

    y += speedY;        // positie updaten
    x += speedX;

    distance = radius + coins[0].coinRadius;  //Voor collision tussen de player en coin.
  }

  void display()
  {
    fill(0);
    text("Score: " + score, 30, 680);

    fill(100, 100, 220);
//  ellipse(x, y, w, h);
    image(Player, x - (w / 2), y - (h / 2), w, h);
  }
  
void place(float x, float y){
this.x = x;
this.y = y;
  }
}
