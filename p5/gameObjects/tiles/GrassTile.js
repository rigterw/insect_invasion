class GrassTile extends Tile {

    constructor(posX, posY, color) {
        const nTextures = 20;
        super(posX, posY, color, `grassTile${Math.floor(random(nTextures))}`, false);
    }
}