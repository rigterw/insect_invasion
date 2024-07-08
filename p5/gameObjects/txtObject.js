class TxtObject extends GameObject{


    constructor(text, x, y,  fontSize,fontType = "text", color = 0) {
        super();
        this.x = x;
        this.y = y;
        this.text = text;
        this.font = font[fontType];
        this.fontSize = fontSize;
        this.color = color;
    }

    draw() {
        fill(this.color);
        textFont(this.font, this.fontSize);
        text(this.text, this.x, this.y);
    }
}