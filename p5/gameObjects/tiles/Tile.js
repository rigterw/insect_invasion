class Tile extends GameObject {

    static size = 40;

    constructor(posX, posY, color, textureName, canWind) {
        super();
        this.x = posX;
        this.y = posY;
        this.color = color;
        this.textureName = textureName;
        this.canWind = canWind;
    }

    draw() {
        image(IMG[this.textureName], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
        fill(`#${this.color}`);
        rect(this.x * Tile.size, this.y * Tile.size, Tile.size / 2, Tile.size / 2);
    }
}