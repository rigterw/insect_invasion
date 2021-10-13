class Player
{
  float x, y, w, h;
  float speedX, speedY, maxSpeed;
  
  Player()
  {
    x = width/2;
    y = height/2;
    w = 24;
    h = 24;
    maxSpeed = 2;
    speedX = 0;
    speedY = 0;
  }
  
  void update()
  {
    if(left == true)    // horizontaal bewegen
    {
     // speedY = 0;     ////////* uitgezet zodat de lateral movement werkt
      speedX = -maxSpeed;
    }
    
    if(right == true)
    {
     // speedY = 0;     ///////*
      speedX = maxSpeed;
    }
    
    if((left == false && right == false) || (left == true && right == true))
    {
     speedX = 0;
    }
    
    
  if(up == true)        // verticaal bewegen
  {
   // speedX = 0;       ////////*
    speedY = -maxSpeed;
  }
  
  if(down == true) 
  {
   // speedX = 0;       ////////*
    speedY = maxSpeed;
  }
    
  if((up == false && down == false) || (up == true && down == true))
  {
    speedY = 0;
  }
  


    y += speedY;        // positie updaten
    x += speedX;
  }
  
 void display()
 {
    fill(100, 100, 220);
    ellipse(x, y, w, h);
 }
}
