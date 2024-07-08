class PlayState extends GameState {
    static instance;
    nLevels = 6;
    tutorial = true;
    currentLvl = 0;
    playing = true;

    player = new Player();
    timer;
    enemies = [];

    currentTile;

    constructor() {
        super();
        PlayState.instance = this;
        this.loadLevel(this.currentLvl);
    }

    update() {
        if (!this.playing)
            return;
        super.update();

        for (let i = 0; i < this.enemies.length; i++){
            if (this.enemies[i].killedPlayer(this.player)) {
                this.showGameOver();
                return;
            }
        }

        let px = Math.floor(this.player.x / Tile.size);
        let py = Math.floor(this.player.y / Tile.size);

        if (px < 0 || px > this.tiles.length || py < 0 || py > this.tiles[px].length)
            return;

        let lastTile = this.currentTile;

        this.currentTile = this.tiles[px][py];

        if (lastTile != this.currentTile){

            if (lastTile instanceof WalkableTile) {
                lastTile.onPlayerExit();
            }
            if (this.currentTile instanceof WalkableTile) {
                this.currentTile.onPlayerEnter();
                if (this.currentTile instanceof FinishTile) {
                    return;
                }
            }
        }

        const neighbours = this.currentTile.getNeighbours(this.tiles);
        this.player.handleTileColission(neighbours);
    }

    draw() {
        super.draw();
        this.drawWind();
    }

    drawWind() {
        for (let x = 0; x < this.tiles.length; x++) {
            for (let y = 0; y < this.tiles[x].length; y++) {

                const tile = this.tiles[x][y];
                if (!(tile instanceof WalkableTile) || tile.windDir == "" || tile.windDir == undefined) {
                    continue;
                }
                push();
                translate((tile.x + 0.5) * Tile.size, (tile.y + 0.5 ) * Tile.size);
                
                imageMode(CENTER);
                let rotation;

                switch (tile.windDir) {
                    case "R":
                        rotation = -0.5 * PI;
                        break;
                    case "B":
                        rotation = 0;
                        break;
                    case "L":
                        rotation = 0.5 * PI;
                        break;
                    case "T":
                        rotation = PI;
                        break;
                    }
                rotate(rotation);
                image(getAnim("wind", 5), 0, 0, Tile.size, Tile.size);
                pop();
            }
        }
    }

    loadLevel(id) {
        this.clear();
        this.currentLvl = id;

        const levelImg = IMG[`level${id}`];
        const levelOverlay = IMG[`level${id}O`];
        
        this.tiles = createArray(levelImg.width, levelImg.height);
        
        for (let x = 0; x < levelImg.width; x++) {
            for (let y = 0; y < levelImg.height; y++) {
                let tile = null;
                
                const color = hex(levelImg.get(x, y));
                const overlayColor = hex(levelOverlay.get(x, y));
                let colorHex = color[0].slice(-2) + color[1].slice(-2) + color[2].slice(-2);
                let overlayColorHex = overlayColor[0].slice(-2) + overlayColor[1].slice(-2) + overlayColor[2].slice(-2);
                switch (colorHex) {
                    case "7F3300":
                    case "FF3819":
                    case "CECECE":
                        tile = new EnemyWalkTile(x, y, overlayColorHex, colorHex == "FF3819", colorHex != "CECECE");
                        break;
                    case "CE7C38":
                        tile = new WalkTile(x, y, overlayColorHex, true);
                        break;
                    case "00FFFF":
                        tile = new ButtonTile(x, y, overlayColorHex);
                        break;
                    
                    case "4C64FF":
                    case "0026FF":
                        const isOpen = colorHex == "4C64FF";
                        tile = new DoorTile(x, y, overlayColorHex, isOpen);
                        break;
                    
                    case "F2FF02":
                        tile = new FinishTile(x, y, overlayColorHex);
                        break;
                    
                    case "404040":
                        tile = new OneWayTile(x, y, overlayColorHex);
                        
                        break;
                    case "808080":
                        tile = new WindTile(x, y, overlayColorHex);
                        break;
                        default:
                            tile = new GrassTile(x, y, overlayColorHex);
                    }
                if (tile != null) {
                    this.tiles[x][y] = tile;
                    this.logicObjects.push(tile);
                    this.visibleObjects.push(tile);
                }
            }
        }
        this.LoadObjects();
    }
            
    LoadObjects() {
        
        for (let x = 0; x < this.tiles.length; x++) {
            for (let y = 0; y < this.tiles[x].length; y++) {
                
                if (!(this.tiles[x][y] instanceof WalkableTile)) {
                    continue;
                }
                let obj;
                
                switch (this.tiles[x][y].color) {
                    case "00FF21":
                        obj = new Player((x + 0.5) * Tile.size, (y + 0.5) * Tile.size);
                        this.player = obj;
                        this.inputObjects.push(this.player);
                        break;
                        
                        case "FF0000":
                            if (this.tiles[x][y] instanceof EnemyWalkTile) {
                                
                                obj = new WalkingEnemy((x + 0.5) * Tile.size, (y + 0.5) * Tile.size, this.tiles[x][y]);
                                this.enemies.push(obj);
                            }
                            break;
                            
                            case "FF6A00":
                                if (this.tiles[x][y] instanceof EnemyWalkTile) {
                                    
                                    obj = new StaticEnemy((x + 0.5) * Tile.size, (y + 0.5) * Tile.size);
                                    
                                    this.enemies.push(obj);
                                }
                                break;
                    
                                case "FFD800":
                                    if (!(this.tiles[x][y] instanceof FinishTile)) {
                                        obj = new Coin(x, y);
                                    }
                                }
                                if (obj != undefined && obj != null) {
                                    
                                    this.logicObjects.push(obj);
                                    this.visibleObjects.push(obj);
                                }
                            }
                        }
                        
                        
        this.timer = new Timer();
        this.logicObjects.push(this.timer);
        this.visibleObjects.push(this.timer);
    }

    handleInput(pressed) {
        super.handleInput(pressed);
        if (!pressed)
            return;

        switch (keyCode) {
            case (82):
                if (!this.playing) {
                    this.clear();
                    console.log("clear");
                    this.playing = true;
                    this.loadLevel(this.currentLvl);
                }
                break;
        }

    }

    showGameOver() {
        this.playing = false;
        this.visibleObjects.push(new TxtObject("GAME OVER", width/3, height/3, 200, 'text', 255))
    }

    clear() {
        super.clear();
        this.enemies = [];
    }
}