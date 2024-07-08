class EnemyWalkTile extends WalkTile {
    constructor(posX, posY, color, unWanted, canWind) {
        super(posX, posY, color);
        this.unWanted = unWanted;
        if (!canWind) {
            this.windDir = undefined;
        }
    }
}