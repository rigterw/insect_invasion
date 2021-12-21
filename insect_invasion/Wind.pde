class Wind {
  String direction; //direction the wind is pushing the player
  int windX, windY;// the location of the starting wind tile
  int MaxLength; // the maximum length of the wind
  
  //initializing the Wind class object
  Wind(int x, int y, String direction, int Length) {
    windX = x;
    windY = y;
    this.direction = direction;
    MaxLength = Length;
  }

//drawing the wind tiles into the levels walkable floor
  void drawWind() {
    for (int i = 0; i < MaxLength; i++) {
      for (int j = 1; j < MaxLength; j++) {
        //initializing the windtile
        Tile wind = null;
        
        //checking the direction of which the walkable tiles need to be filled
        switch(direction) {
        case "north":
          wind = tiles[windX][windY+i];
          break;
        case "west":
          wind = tiles[windX+i][windY];
          break;
        case "east":
          wind = tiles[windX-i][windY+i];
          break;
        case "south":
          wind = tiles[windX][windY-i];
          break;
        }
        
        //if the wind hits a door stop the loop
        if (wind.type == "door") {
          println("door hit");
          MaxLength = i;
        }
        //if the floor is a walkable tile change it into a windtile
        if (wind.type == "walkable") 
        {
          wind.type = "windtile";
          wind.tile = windTile;
        }
      }
    }
  }
}
