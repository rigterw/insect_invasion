class DoorTile extends WalkTile {

    constructor(posX, posY, color, passable) {
        super(posX, posY, color, true, passable);
        console.log(`door ${posX} ${passable}`);
    }
    
    draw() {
        super.draw();
        const imgName = this.passable ? "doorOpenTile" : "doorTile";
        tint("#" + this.color);
        image(IMG[imgName], this.x * Tile.size, this.y * Tile.size + Tile.size * 0.1, Tile.size * 0.9, Tile.size * 0.9);
        noTint();
    }
}