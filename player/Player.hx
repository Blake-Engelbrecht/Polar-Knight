package player;

import flixel.FlxG;
import flixel.FlxObject;
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
class Player extends FlxSprite
{
	// Player Sprite Animations
	private var idleAnimations = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	private var runAnimations = [11, 12, 13, 14, 15, 16, 17, 18];
	private var jumpAnimations = [19, 20, 21];
	private var fallAnimations = [22, 23, 24];
	private var damageAnimations = [25, 26, 27, 28];
	private var deathAnimations = [29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39];

	final SPEED:Int = 100;
	final GRAVITY:Int = 300;

	public function new(xPos:Int = 100, yPos:Int = 320)
	{
		super(xPos, yPos);
		drag.x = SPEED * 3.5;
		acceleration.y = GRAVITY;

		loadGraphic("assets/images/player/PolarKnightSpriteSheet.png", true, 180, 180);
		animation.add("idle", idleAnimations, 9);
		animation.add("run", runAnimations, 9);
		animation.add("jump", jumpAnimations, 9);
		animation.add("fall", fallAnimations, 9);
		animation.add("damage", damageAnimations, 9);
		animation.add("death", deathAnimations, 9);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	function movement()
	{
		final left = FlxG.keys.anyPressed([LEFT]);
		final right = FlxG.keys.anyPressed([RIGHT]);

		if ((left || right) && !(left && right))
		{
			animation.play("run");
		}
		else
		{
			animation.play("idle");
		}

		if (left && right)
		{
			velocity.x = 0;
		}
		else if (left)
		{
			velocity.x = -SPEED;
			facing = FlxObject.LEFT;
		}
		else if (right)
		{
			velocity.x = SPEED;
			facing = FlxObject.RIGHT;
		}
	}

	function jumping()
	{
		final jump = FlxG.keys.justPressed.UP;

		if (jump && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -GRAVITY / 1.7;
		}
	}

	override function update(elapsed:Float)
	{
		jumping();
		super.update(elapsed);
		movement();
	}
}
