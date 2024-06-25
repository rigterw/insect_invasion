class Tile extends GameObject {

    size = 40;

    constructor(posX, posY, color, textureName, canWind) {
        super();
        this.x = posX;
        this.y = posY;
        this.color = color;
        this.textureName = textureName;
        this.canWind = canWind;
    }

    draw() {
        image(img[this.textureName], this.x * this.size, this.y * this.size, this.size, this.size);
    }
}