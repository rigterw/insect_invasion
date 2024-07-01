class PlayState extends GameState {

    nLevels = 6;

    player = new Player();

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
        const neighbours = this.tiles[px][py].getNeighbours(this.tiles);
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
                        tile = new WalkTile(x, y, overlayColorHex);
                        break;
                    case "00FFFF":
                        tile = new ButtonTile(x, y, overlayColorHex);
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
                if (x == 3 && y == 4) {
                    console.log(this.tiles[x][y].color);
                }
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