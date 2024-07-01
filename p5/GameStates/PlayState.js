class PlayState extends GameState {

    nLevels = 6;

    player = new Player();

    currentTile;

    constructor() {
        super();
        this.LoadLevel(0);
    }

    update() {
        super.update();

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

    LoadLevel(id) {
        this.clear();

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
                    case "CE7C38":
                    case "7F3300":
                        tile = new WalkTile(x, y, overlayColorHex, colorHex == "7F3300");
                        break;
                    case "00FFFF":
                        tile = new ButtonTile(x, y, overlayColorHex, this);
                        break;
                    
                    case "4C64FF":
                    case "0026FF":
                        const isOpen = colorHex == "4C64FF";
                        tile = new DoorTile(x, y, overlayColorHex, isOpen);
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
                    case ("00FF21"):
                        this.player.x = (x + 0.5) * Tile.size;
                        this.player.y = (y + 0.5) * Tile.size;
                        console.log("player");
                        break;
                }
            }
        }
    }
}