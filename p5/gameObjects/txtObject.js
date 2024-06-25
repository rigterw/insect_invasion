class TxtObject extends GameObject{


    constructor(gameState, text, position, fontType, fontSize, color = 0) {
        super();
        this.position = position;
        this.text = text;
        console.log(font[fontType]);
        this.font = font[fontType];
        this.fontSize = fontSize;
        this.color = color;
        gameState.visibleObjects.push(this);
    }

    draw() {
        fill(this.color);
        textFont(this.font, this.fontSize);
        text(this.text, this.position.x, this.position.y);
    }
}