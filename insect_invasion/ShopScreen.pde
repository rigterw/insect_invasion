class ShopScreen {

  //Variables for the size of the shop window
  float shopX, shopY;
  float shopW = 580; 
  float shopH = 600;

  //Upper bar of the shop window
  float upperShopBarX; 
  float upperShopBarY;
  float upperShopBarW = shopW;
  float upperShopBarH = 60;

  //Lower bar of the shop window
  float lowerShopBarX;
  float lowerShopBarY;
  float lowerShopBarW = shopW;
  float lowerShopBarH = 60;


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
  String playerInventory = "Inventory: " + p.score + "x"; 
  String exitUItext = "Press      to exit";
  String buyUItext = "Press      to purchase";

  //Integer to keep track of the selected tab.ppp
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

    skinTabs[0] = new SkinTab(shopX + space, shopY + space, 1);
    skinTabs[1] = new SkinTab(shopX + space + skinTabW + space, shopY + space, 2);
    skinTabs[2] = new SkinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space, 3);
    skinTabs[3] = new SkinTab(shopX + space, shopY + space + skinTabH + space, 4);
    skinTabs[4] = new SkinTab(shopX + space + skinTabW + space, shopY + space + skinTabH + space, 5);
    skinTabs[5] = new SkinTab(shopX + space + skinTabW + space + skinTabW + space, shopY + space + skinTabH + space, 6);
  }
  //Method where the shop gets drawn (not the skin tabs)
  //Two arguments to place the shop somewhere in the game screen. 
  void drawShop(float shopX_, float shopY_) {
    shopX = shopX_;
    shopY = shopY_;

    upperShopBarX = shopX;
    upperShopBarY = shopY - 50;
    lowerShopBarX = shopX;
    lowerShopBarY = shopY + 550;

    textAlign(CENTER);

    //Upper bar of the shop, colored black.
    stroke(0);
    fill(0);
    rect(upperShopBarX, upperShopBarY, upperShopBarW, upperShopBarH); 
    textSize(textSize);
    fill(textColor);
    text(shopText, upperShopBarX + upperShopBarW/2, upperShopBarH + 20);


    //Middle portion of the shop
    fill(shopColor);
    rect(shopX, shopY, shopW, shopH);

    //Lower bar of the shop.
    textAlign(CENTER);
    fill(0);
    rect(lowerShopBarX, lowerShopBarY, lowerShopBarW, lowerShopBarH);
    fill(textColor);
    textSize(textSize);
    text(playerInventory, lowerShopBarX + lowerShopBarW/2, lowerShopBarY - 25);
    image(timeCoin, lowerShopBarX + lowerShopBarW/2 + 57, lowerShopBarY - 52);
    //User Interface text:
    //B to Exit, A to Purchase
    textAlign(CENTER, CENTER);
    text(exitUItext, lowerShopBarX + lowerShopBarW /4, lowerShopBarY + lowerShopBarH /2);
    image(bButton, lowerShopBarX + lowerShopBarW /4 - 22.5, lowerShopBarY + lowerShopBarH/3);
    
    text(buyUItext, lowerShopBarX + lowerShopBarW * 0.75, lowerShopBarY + lowerShopBarH/2);
    image(aButton, lowerShopBarX + lowerShopBarW * 0.60 + 44, lowerShopBarY + lowerShopBarH/3);  
}

  //Method to navigate within the shop window
  //Uses the variable selectedTab to assign a number to each shop tab.
  void keyPressed() {
    //A || LEFT on the controller
    if (keyCode == 65) {
      selectedTab--;
      if (selectedTab == 0) {
        selectedTab = 6;
      }
    }
    //D || RIGHT on the controller
    if (keyCode == 68) {
      selectedTab++;
      if (selectedTab == 7) {
        selectedTab = 1;
      }
    }
    // S || DOWN on the controller
    if (keyCode == 83 && selectedTab <= 3) {
      selectedTab += 3;
    }
    //W ||UP  on the controller
    if (keyCode == 87 && selectedTab >= 4) {
      selectedTab -= 3;
    }
    //R || A on the controller
    //Buys a skin
    //For every tab; if pressed, sets isBuyable on false
    if (keyCode == 82) {
      for (int i = 0; i < skinTabAmount; i++) {
        if (skinTabs[i].selected && skinTabs[i].isBuyable) {
          skinTabs[i].isBuyable = false;
        }
      }
    }
    //E || B on the controller
    //Exits the shop
    if (keyCode == 69) {
      stage = 3;
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
    color selectedColor = color(200, 200, 200);
    color buyColor = color(255);
    color bought = color(255, 0, 0);

    //String to display the text on the tab
    String buyText = "Buy: ";

    //Variable to declare the cost of the skins
    int skinCost; 

    //Boolean to determine if a skin tab is selected.
    boolean selected;
    //Boolean to see if a skin is purchaseable
    boolean isBuyable; 

    //Constructor for the skin tab
    //Two arguments to place the tabs somewhere.
    SkinTab(float xPos_, float yPos_, int skinCost_) {
      x = xPos_;
      y = yPos_;
      selected = false;
      isBuyable = true;
      skinCost = skinCost_;
      textAlign(CENTER,BOTTOM);
    }

    //Draw function for the tabs
    void draw() {
      //Making the skin tab. 

      for (int i = 0; i <skinTabAmount; i++) {
        if (skinTabs[i].isBuyable == false) {
          skinTabs[i].buyColor = color(bought);
        }
      }
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
      textAlign(CENTER,CENTER);
      fill(buyColor);
      textSize(25);
      text(buyText, x + skinTabW/2 - 15, y + skinTabH - 20);
      text(skinCost + "x", x + skinTabW/1.8, y + skinTabH - 20);
      image(timeCoin, x + skinTabW/1.5, y + skinTabH - 36);
    }

    //Method to select different skin tabs
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
