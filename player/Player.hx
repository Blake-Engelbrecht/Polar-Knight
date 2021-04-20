package player;

import flixel.FlxG;
import flixel.FlxSprite;

/**
* Polar Knight Sprite Sheet Guide:
* Idle = 0-10
* Run = 11-18
* Jump = 19-21
* Fall = 22-24
* Damage = 25-28
* Death = 29-39
*/



class Player extends FlxSprite {
    //Player Sprite Animations
    private var idleAnimations = [0,1,2,3,4,5,6,7,8,9,10];
    private var runAnimations = [11,12,13,14,15,16,17,18];
    private var jumpAnimations = [19,20,21];
    private var fallAnimations = [22,23,24];
    private var damageAnimations = [25,26,27,28];
    private var deathAnimations = [29,30,31,32,33,34,35,36,37,38,39];

    final SPEED:Int = 100;

    public function new(xPos:Int = 500, yPos:Int = 200) {
        super(xPos, yPos);
        loadGraphic("assets/images/player/PolarKnightSpriteSheet.png", true, 180, 180);
        animation.add("idle", runAnimations, 8);
        animation.play("idle"); 
        drag.x = SPEED * 3;       
    }

    private function movement() {
        final left = FlxG.keys.anyPressed([LEFT]);
        final right = FlxG.keys.anyPressed([RIGHT]);
        
        if (right) {
            velocity.x = SPEED;
        }
        if (left) {
            velocity.x = -SPEED;
        }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        movement();                
    }
}