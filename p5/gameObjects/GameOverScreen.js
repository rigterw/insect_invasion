class GameOverScreen extends GameObject {
    texts = [];

    constructor() {
        super();
        let highScoreTxt = `Highscore: ${highScore}`;
        cookieManager.setCookie("coins", coins);
        if (score > highScore) {
            cookieManager.setCookie("highScore", score);
            highScoreTxt = "NEW HIGHSCORE";
        }
        this.texts.push(new TxtObject("GAME OVER", width / 2, height / 5, 200, 'text', 255));
        this.texts.push(new TxtObject(highScoreTxt, width / 2, height / 2 + height / 10, 50, 'text', 0));
        this.texts.push(new TxtObject(`Press "R" to restart`, width / 2, height / 2 + 150, 100, 'text', 255));
        this.texts.push(new TxtObject(`Press "E" for shop`, width / 2, height / 2 + 250, 100, 'text', 255));

    }

    draw() {
        textAlign(CENTER, CENTER);

        for (let i = 0; i < this.texts.length; i++) {
            this.texts[i].draw();
        }
    }

    handleInput(pressed) {
        if (!pressed)
            return;

        switch (keyCode) {
            case (82):
                const playState = PlayState.instance;
                const nextLvl = playState.tutorial ? playState.currentLvl : Math.floor(random(PlayState.instance.nLevels));

                if (!playState.tutorial) {
                    score = 0;
                }

                playState.loadLevel(nextLvl);
                break;

            case (69):
                gameStateManager.switchState("ShopState");
        }
    }
}