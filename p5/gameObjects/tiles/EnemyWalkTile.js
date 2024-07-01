class EnemyWalkTile extends WalkTile {
    constructor(posX, posY, color, unWanted) {
        super(posX, posY, color);
        this.unWanted = unWanted;
    }
}