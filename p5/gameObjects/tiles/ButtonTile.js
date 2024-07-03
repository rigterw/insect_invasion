class ButtonTile extends WalkTile {


    constructor(x, y, color) {
        super(x, y, color, true);
    }

    draw() {
        super.draw();
        const imgName = this.standingOn ? "buttonPressedTile" : "buttonTile";
        tint("#" + this.color);
        image(IMG[imgName], this.x * Tile.size, this.y * Tile.size + Tile.size * 0.1, Tile.size * 0.9, Tile.size * 0.9);
        noTint();
    }

    onPlayerEnter() {
        super.onPlayerEnter();

        for (let x = 0; x < PlayState.instance.tiles.length; x++){
            for (let y = 0; y < PlayState.instance.tiles[x].length; y++){
                const currentTile = PlayState.instance.tiles[x][y];

                if (currentTile instanceof DoorTile && currentTile.color == this.color ) {
                    currentTile.passable = !currentTile.passable;
                }

            }
        }
    }
}