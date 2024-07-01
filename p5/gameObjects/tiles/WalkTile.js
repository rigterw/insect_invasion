class WalkTile extends WalkableTile {

    constructor(posX, posY, color, enemyPassable, passable = true) {
        let nTextures = 4;
        super(posX, posY, color, `walkTile${Math.floor(random(nTextures))}`, passable);
        this.enemyPassable = enemyPassable;
        if (this instanceof DoorTile) {
            
            console.log(`walk ${posX} ${this.passable}`);
        }
    }
}