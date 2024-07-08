class GameOverScreen extends GameObject {
    texts = [];

    constructor() {
        super();
        this.texts.push(new TxtObject("GAME OVER", width / 2, height / 5, 200, 'text', 255));
        this.texts.push(new TxtObject(`Press "R" to restart`, width / 2.2, height / 2 + 200, 100, 'text', 255));
        this.texts.push(new TxtObject(`Press "E" for shop`, width / 2.2, height / 2 + 300, 100, 'text', 255));

    }

    draw() {
        textAlign(CENTER, CENTER);

        for (let i = 0; i < this.texts.length; i++){
            this.texts[i].draw();
        }
    }

    handleInput(pressed) {
        if (!pressed)
            return;

        switch (keyCode) {
            
        }
    }
}