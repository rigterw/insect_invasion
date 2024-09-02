class FinishTile extends WalkTile {
    constructor(posX, posY, color) {
        super(posX, posY, color);
    }

    draw() {
        super.draw();
        image(IMG["finishTile"], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
    }

    onPlayerEnter() {
        score += Math.floor(PlayState.instance.timer.time);
        if (score > highScore) {
            cookieManager.setCookie("highScore", score);
        }
        cookieManager.setCookie("coins", coins);
        SOUND["finish"].play();
        if (PlayState.instance.tutorial) {
            if (PlayState.instance.currentLvl >= PlayState.instance.nLevels) {
                PlayState.instance.tutorial = false;
            }
            else {
                PlayState.instance.loadLevel(PlayState.instance.currentLvl + 1);
                return;
            }
        }

        let nextMap;

        do {
            nextMap = Math.floor(random(PlayState.instance.nLevels));
        } while (nextMap == PlayState.instance.currentLvl);

        PlayState.instance.loadLevel(nextMap);
    }
}