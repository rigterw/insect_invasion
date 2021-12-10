class Player
{
  float x, y, w, h; //x and y position, width and height from the player
  float speedX, speedY, maxSpeed; //Player movement speed
  float radius; //Player radius for the collisions
  float distance; //Distance used for the collision between player and coin
  int playerTileX, playerTileY; //Tile the player is located on
  int score; // Score (picked up coins)

  /*
   * No argument constructor for the Player class
   */
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

  /*
   * Method to update the player
   * @return void
   */
  void update()
  {
    //checking if the player wants to move left
    if (left == true)
    {
      // speedY = 0;     // commented so lateral movement works
      //seting the speed
      speedX = -maxSpeed;
    }

    //checking if the player wants to move right
    if (right == true)
    {
      // speedY = 0;     // commented so lateral movement works
      speedX = maxSpeed;
    }

    //checking if the player wants to move right and left, or neither of those
    if ((left == false && right == false) || (left == true && right == true))
    {
      speedX = 0;
    }

    //checking if the player wants to move up
    if (up == true)
    {
      // speedX = 0;       // commented so lateral movement works
      speedY = -maxSpeed;
    }

    //checking if the player wants to move down
    if (down == true) 
    {
      // speedX = 0;       // commented so lateral movement works
      speedY = maxSpeed;
    }

    //checking if the player wants to move up and down, or neither of those
    if ((up == false && down == false) || (up == true && down == true))
    {
      speedY = 0;
    }

    //updating the position
    y += speedY;       
    x += speedX;

    //setting the distance for the coin collision
    distance = radius + coins[0].coinRadius;
  }

  /*
   * Method to display the player
   * @return void
   */
  void display()
  {
    fill(0);
    //displaying the score text
    textAlign(LEFT);
    text("Score: " + score, 30, 680);

    fill(100, 100, 220);

    //displaying the player
    image(Player, x - (w / 2), y - (h / 2), w, h);
  }

  /*
   * Method to place the player
   * @param float x
   * @parm float y
   * @return void
   */
  void place(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
