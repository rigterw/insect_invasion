class PlayState extends GameState {
    static instance;
    nLevels = 6;
    tutorial = true;
    currentLvl = 3;
    alive = true;

    player = new Player();
    enemies = [];

    currentTile;

    constructor() {
        super();
        PlayState.instance = this;
        this.loadLevel(this.currentLvl);
    }

    update() {
        if (!this.alive)
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
            }
        }

        const neighbours = this.currentTile.getNeighbours(this.tiles);
        this.player.handleTileColission(neighbours);
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
                        tile = new EnemyWalkTile(x, y, overlayColorHex, colorHex == "FF3819");
                        break;
                    case "CE7C38":
                        tile = new WalkTile(x, y, overlayColorHex);
                        break;
                    case "00FFFF":
                        tile = new ButtonTile(x, y, overlayColorHex, this);
                        break;
                    
                    case "4C64FF":
                    case "0026FF":
                        const isOpen = colorHex == "4C64FF";
                        tile = new DoorTile(x, y, overlayColorHex, isOpen);
                        break;
                    
                    case "F2FF02":
                        tile = new FinishTile(x, y, overlayColorHex,this);
                        break;
                    default:
                        tile = new GrassTile(x, y, overlayColorHex);
                }
                if (tile != null) {
                    this.tiles[x][y] = tile;
                    this.visibleObjects.push(tile);
                }
            }
        }
        this.LoadObjects();
    }
            
    LoadObjects() {
        this.logicObjects.push(this.player);
        this.visibleObjects.push(this.player);

        for (let x = 0; x < this.tiles.length; x++) {
            for (let y = 0; y < this.tiles[x].length; y++) {
                switch (this.tiles[x][y].color) {
                    case "00FF21":
                        this.player.x = (x + 0.5) * Tile.size;
                        this.player.y = (y + 0.5) * Tile.size;
                        break;
                    
                    case "FF0000":
                        const enemy = new WalkingEnemy((x + 0.5) * Tile.size, (y + 0.5) * Tile.size, this.tiles[x][y]);
                        this.logicObjects.push(enemy);
                        this.visibleObjects.push(enemy);
                        this.enemies.push(enemy);
                }
            }
        }
    }

    handleInput(pressed) {
        if (!pressed)
            return;

        switch (keyCode) {
            case (82):
                if (!this.alive) {
                    this.clear();
                    console.log("clear");
                    this.alive = true;
                    this.loadLevel(this.currentLvl);
                }
                break;
        }
    }

    showGameOver() {
        this.alive = false;
        this.visibleObjects.push(new txtObject("GAME OVER", width/3, height/3, 200, 'text', 255))
    }

    clear() {
        super.clear();
        this.enemies = [];
    }
}