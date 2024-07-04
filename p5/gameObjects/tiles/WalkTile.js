class WalkTile extends WalkableTile {

    constructor(posX, posY, color, passable = true, canWind = true) {

        let nTextures = 4;
        super(posX, posY, color, `walkTile${Math.floor(random(nTextures))}`, passable);
        if (!canWind) {
            console.log(posY);
            this.windDir = undefined;
        }
    }
}