package player;

import flixel.FlxSprite;

class Player extends FlxSprite {
    public function new(xPos:Int = 500, yPos:Int = 200) {
        super(xPos, yPos);
        loadGraphic("assets/images/player/Idle.png", true, 64, 64);
        
    }
}