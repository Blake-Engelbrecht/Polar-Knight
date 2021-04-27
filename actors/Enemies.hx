package actors;

import flixel.FlxObject;
import flixel.FlxSprite;

enum EnemyType
{
	FlyingEye;
}

class Enemy extends FlxSprite
{
	final SPEED:Int = 120;

	var type:EnemyType;

	public function new(xPos:Int = 100, yPos:Int = 50, type:EnemyType)
	{
		super(xPos, yPos);
		this.type = type;

		drag.x = drag.y = 10;
		width = 8;
		height = 14;
		offset.x = 4;
		offset.y = 2;

		loadGraphic("assets/images/enemies/FlyingEyeSprite.png", true, 150, 150);
		animation.add("idle", [0, 1, 2, 3, 4, 5], 6, true);

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}

	public function movement()
	{
		animation.play("idle");
		if ((velocity.x != 0) && touching == FlxObject.NONE)
		{
			if (velocity.x < 0)
			{
				facing = FlxObject.LEFT;
			}
			else
			{
				facing = FlxObject.RIGHT;
			}
		}
	}

	override public function update(elapsed:Float)
	{
		movement();
		super.update(elapsed);
	}
}
