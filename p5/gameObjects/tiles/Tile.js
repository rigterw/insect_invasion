class Tile extends GameObject {

    static size = 40;
    standingOn = false;

    constructor(posX, posY, color, textureName, passable) {
        super();
        this.x = posX;
        this.y = posY;
        this.color = color;
        this.textureName = textureName;
        this.passable = passable;
    }

    draw() {
        image(IMG[this.textureName], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
        fill(`#${this.color}`);
        rect(this.x * Tile.size, this.y * Tile.size, Tile.size / 3, Tile.size / 3);
    }



    getNeighbours(tiles) {
        const x = this.x;
        const y = this.y;
        const neighbours = {}

        if (x > 0) {
            neighbours["L"] = tiles[x - 1][y];
            if (y > 0) {
                neighbours["TL"] = tiles[x - 1][y - 1];
            }
            if (y < tiles[x-1].length - 1) {
                neighbours["BL"] = tiles[x-1][y + 1];
            }
        }

        if (y > 0) {
            neighbours["T"] = tiles[x][y - 1];
        }
        
        if (y < tiles[x].length - 1) {
            neighbours["B"] = tiles[x][y + 1];
        }

        if (x < tiles.length - 1) {
            neighbours["R"] = tiles[x + 1][y];
            if (y > 0) {
                neighbours["TR"] = tiles[x + 1][y - 1];
            }
            if (y < tiles[x+1].length - 1) {
                neighbours["BR"] = tiles[x + 1][y + 1];
            }
        }

        return neighbours;
    }
}