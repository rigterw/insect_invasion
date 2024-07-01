class DoorTile extends WalkTile {

    constructor(posX, posY, color, passable) {
        super(posX, posY, color, passable);
    }
    
    draw() {
        super.draw();
        const imgName = this.passable ? "doorOpenTile" : "doorTile";
        tint("#" + this.color);
        image(IMG[imgName], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
        noTint();
    }
}