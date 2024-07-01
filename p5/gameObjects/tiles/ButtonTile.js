class ButtonTile extends WalkTile {

    pressed = false;

    constructor(x, y, color) {
        super(x, y, color);
    }

    draw() {
        super.draw();
        const imgName = this.pressed ? "buttonPressedTile" : "buttonTile";
        tint("#" + this.color);
        image(IMG[imgName], this.x * Tile.size, this.y * Tile.size + Tile.size * 0.1, Tile.size * 0.9, Tile.size * 0.9);
        noTint();
    }
}