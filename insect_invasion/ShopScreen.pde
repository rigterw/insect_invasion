class ShopScreen {

  //Variables for the size of the shop window
  float shopX, shopY;
  float shopW = 580; 
  float shopH = 600;

  //Variables for the size of the upper bar of the shop window.
  float skinTabW = 140;
  float skinTabH = 200;

  //Color variables for the shop window
  color shopColor = color(100, 5, 240);
  color skinTabColor = color(75, 25, 150);
  color textColor = color(255);
  color skinColor = color(0);

  //Multiple strings 
  float textSize = 30;
  String shopText = "Shop";
  String buyText = "Buy: ";
  String collectedCurrency = "Currency:   "; 

  //Variable to declare the cost of the skins
  float cost = random(1, 10);


  void draw() { 
    shop(100, 100);
  }


  //Method where the shop gets drawn
  // Two arguments to place the shop somewhere in the game screen. 
  void shop(float shopX_, float shopY_) {

    shopX = shopX_;
    shopY = shopY_; 

    //Variable for space between the tabs and in the shop window.
    float space = 40;

    //Upper bar of the shop, colored black.
    stroke(0);
    fill(0);
    rect(shopX, shopY - 50, shopW, shopH - 540); 
    textSize(textSize);
    fill(textColor);
    text(shopText, shopX + 260, shopY -10);

    //Rest of the window of the shop itself.
    fill(shopColor);
    rect(shopX, shopY, shopW, shopH);

    //Lower bar of the shop, users can see their owned coins here
    fill(0);
    rect(shopX, shopY + 520, shopW, shopH - 520);
    fill(textColor);
    textSize(textSize);
    text(collectedCurrency, shopX + 200, shopY + 570 );

    //Different tabs with different skins gets placed in the shop.
    skinTab(shopX + space, shopY + space, color(255, 0, 0), 6);
    skinTab(shopX + space + skinTabW + space, shopY + space, color(0, 255, 0), 4);
    skinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space, color(0, 0, 255), 4);
    skinTab(shopX + space, shopY + space + skinTabH + space, color(255, 255, 0), 2);
    skinTab(shopX + space + skinTabW + space, shopY + space + skinTabH + space, color(255, 0, 255), 9);
    skinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space + skinTabH + space, color(0, 255, 255), 10);
  }

  //Method to make the different skin tabs.
  //Two arguments to place the tab somewhere in the shop (xPos_, yPos_)
  //Another argument to determine the color of the skin (skinColorDisplay)
  //And lastly a argument to determine the cost of a certain skin (skinCost)
  void skinTab(float xPos_, float yPos_, color skinColorDisplay, int skinCost) {
    stroke(0);
    fill(skinTabColor);
    rect(xPos_, yPos_, skinTabW, skinTabH);
    line(xPos_, yPos_ + 160, xPos_ +140, yPos_ +160);
    fill(skinColorDisplay);
    circle(xPos_ + skinTabW /2, yPos_ + skinTabH /2 - 40, 100 );
    fill(textColor);
    textSize(20);
    text(buyText, xPos_ + 55, yPos_ +187);
    text(skinCost + "x", xPos_ + 80, yPos_ + 187);
    image(timeCoin, xPos_ + 95, yPos_ + 165);
  }
}
