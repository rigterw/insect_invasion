class PlayStateUI extends GameObject {

    draw() {
        fill(0);
        textSize(30);
        
        textAlign(RIGHT, TOP);
        image(IMG["coin"], width - 10 - Coin.width, 30, Coin.width, Coin.height);
        text(coins, width - 20 - Coin.width, 33);
        if (PlayState.instance.playing) {   
            textAlign(LEFT, TOP);
            text(`SCORE: ${score}`, 10, 33);
        } else {
            textAlign(CENTER, TOP);
            textSize(60)
            fill(125);
            text(`SCORE: ${score}`, width /2.2, height /2.2);
        }
    }
}