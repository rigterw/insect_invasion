class ShopScreen {

  //Variables for the size of the shop window
  float shopX, shopY;
  float shopW = 580; 
  float shopH = 600;

  //Variables for the size of the skin tabs
  float skinTabW = 140;
  float skinTabH = 200;

  //Variable for space between the tabs and in the shop window.
  float space = 40;

  //Color variables for the shop window
  color shopColor = color(100, 5, 240);
  color textColor = color(255);

  //Multiple strings 
  float textSize = 30;
  String shopText = "Shop";
  String collectedCurrency = "Inventory:   "; 

  //Variable to declare the cost of the skins
  float cost = int(random(1, 10));

  //Integer to keep track of the selected tab.
  int selectedTab;

  //Making an array of skinTabAmount of skin tabs
  int skinTabAmount = 6; 
  SkinTab[] skinTabs = new SkinTab[skinTabAmount];

  //Method to draw the entire shop;
  //The shop window and the skin tabs.
  void drawEntireShop() { 
    drawShop(width/4, height/8);
    
    //Every skin tab operates the selectSkinTab function; so it can be selected
    //Every skin tab gets drawn on the screen
    for (int i = 0; i < skinTabAmount; i++) {
      skinTabs[i].selectSkinTab();
      skinTabs[i].draw();
    }
  }
  
  //Method to setup the shop, place all the shop tabs in an array at a certain position
  //Two arguments to place the tabs relative to the shopX and shopY.
  void setupShop(float shopX_, float shopY_) {
    shopX = shopX_;
    shopY = shopY_;

    skinTabs[0] = new SkinTab(shopX + space, shopY + space);
    skinTabs[1] = new SkinTab(shopX + space + skinTabW + space, shopY + space);
    skinTabs[2] = new SkinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space);
    skinTabs[3] = new SkinTab(shopX + space, shopY + space + skinTabH + space);
    skinTabs[4] = new SkinTab(shopX + space + skinTabW + space, shopY + space + skinTabH + space);
    skinTabs[5] = new SkinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space + skinTabH + space);
  }
  //Method where the shop gets drawn (not the skin tabs)
  //Two arguments to place the shop somewhere in the game screen. 
  void drawShop(float shopX_, float shopY_) {
    shopX = shopX_;
    shopY = shopY_;

    //Upper bar of the shop, colored black.
    stroke(0);
    fill(0);
    rect(shopX, shopY - 50, shopW, shopH - 540); 
    textSize(textSize);
    fill(textColor);
    text(shopText, shopX + shopW/2, shopY -10);

    //Middle portion of the shop
    fill(shopColor);
    rect(shopX, shopY, shopW, shopH);

    //Lower bar of the shop.
    //Players can see their owned coins here
    fill(0);
    rect(shopX, shopY + 520, shopW, shopH - 520);
    fill(textColor);
    textSize(textSize);
    text(collectedCurrency, shopX + shopW/2, shopY + 570 );
  }

  //Method to navigate within the shop window
  //Uses the variable selectedTab to assign a number to each shop tab.
  void keyPressed() {
    //A || LEFT on the joypad
    if (keyCode == 65) {
      selectedTab--;
    }
    //D || RIGHT on the joypad
    if (keyCode == 68) {
      selectedTab++;
    }
  }

  //Nestled in class for the skin tabs.
  class SkinTab {
    //Variables for the size of the skin tabs
    float x, y;
    float w = 140;
    float h = 200;
    float lineOffset = 160;

    //Colors for the tabs, and for the displayed skin.
    color skinTabColor = color(75, 25, 150);
    color purchaseableColor = color(0);
    color tabStroke = color(0); 
    color circleStroke = color(0);

    //Variables to change the stroke and text color when a tab is selected.
    color selectedColor = color(200,200,200);
    color buyColor = color(255);

    //String to display the text on the tab
    String buyText = "Buy: ";

    //Variable to declare the cost of the skins
    float skinCost = random(1, 10);

    //Boolean to determine if a skin tab is selected.
    boolean selected;


    //Constructor for the skin tab
    //Two arguments to place the tabs somewhere.
    SkinTab(float xPos_, float yPos_) {
      x = xPos_;
      y = yPos_;
      selected = false;
    }

    //Draw function for the tabs
    void draw() {
      //Making the skin tab. 
      stroke(tabStroke);
      fill(skinTabColor);
      rect(x, y, w, h);
      stroke(0);
      line(x, y + lineOffset, x +skinTabW, y +lineOffset);

      //Circle that displays the purchaseable skin
      //------------------------------------------------------CHANGE TO IMAGE-----------------------------------------//
      stroke(circleStroke);
      fill(purchaseableColor);
      circle(x + w /2, y + h /2 - 40, 100 );

      //Text in each tab
      fill(buyColor);
      textSize(25);
      text(buyText, x + skinTabW/3, y + skinTabH - 14);
      text(cost + "x", x + skinTabW/1.8, y + skinTabH - 12);
      image(timeCoin, x + skinTabW/1.45, y + skinTabH - 36);
    }


    //Method select different skin tabs
    void selectSkinTab() {
      selectedTab = constrain(selectedTab, 1, 6);

      //If a tab is selected, change the color of the stroke and the text of that tab
      if (selected == true) {
        tabStroke = color(selectedColor);
        buyColor = selectedColor;
        circleStroke = selectedColor;
      } else { //Otherwise, give them the default colors
        tabStroke = color(0); 
        buyColor = color(255);
        circleStroke = color(0);
      }
      
      //Connects a skin tab to a number of the 'selectedTab' variable
      //Sets the boolean 'selected' to true if they are selected, and false if they are not selected
      if (selectedTab == 1) {
        skinTabs[0].selected = true;
      } else if (selectedTab != 1) {
        skinTabs[0].selected = false;
      }
      if (selectedTab == 2) {
        skinTabs[1].selected = true;
      } else if (selectedTab != 2) {
        skinTabs[1].selected = false;
      }
      if (selectedTab == 3) {
        skinTabs[2].selected = true;
      } else if (selectedTab != 3) {
        skinTabs[2].selected = false;
      }
      if (selectedTab == 4) {
        skinTabs[3].selected = true;
      } else if (selectedTab != 4) {
        skinTabs[3].selected = false;
      }
      if (selectedTab == 5) {
        skinTabs[4].selected = true;
      } else if (selectedTab != 5) {
        skinTabs[4].selected = false;
      }
      if (selectedTab == 6) {
        skinTabs[5].selected = true;
      } else if (selectedTab != 6) {
        skinTabs[5].selected = false;
      }
    }
  }
}
