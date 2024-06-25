class WalkTile extends Tile {

    constructor(posX, posY, color) {
        let nTextures = 4;
        super(posX, posY, color, `walkTile${Math.floor(random(nTextures))}`, true);
    }
}