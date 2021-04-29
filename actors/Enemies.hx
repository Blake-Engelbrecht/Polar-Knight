package actors;

import actors.Fsm;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

enum EnemyType
{
	FlyingEye;
}

class Enemy extends FlxSprite
{
	final SPEED:Int = 120;
	final GRAVITY:Int = 500;
	var type:EnemyType;
	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;

	public function new(xPos:Int = 100, yPos:Int = 50, type:EnemyType)
	{
		super(xPos, yPos);
		this.type = type;

		loadGraphic("assets/images/enemies/FlyingEyeSprite.png", true, 150, 150);
		animation.add("idle", [0, 1, 2, 3, 4, 5], 6, true);

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		drag.x = drag.y = 10;
		width = 16;
		height = 16;
		offset.x = 76;
		offset.y = 72;

		brain = new FSM(idle);
		idleTimer = 0;
		playerPosition = FlxPoint.get();
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

	public function idle(elapsed:Float)
	{
		if (seesPlayer)
		{
			brain.activeState = chase;
		}
		else if (idleTimer <= 0)
		{
			if (FlxG.random.bool(1))
			{
				moveDirection = -1;
				velocity.x = 0;
			}
			else
			{
				moveDirection = FlxG.random.int(0, 8) * 45;

				velocity.set(SPEED * 0.5, 0);
				velocity.rotate(FlxPoint.weak(), moveDirection);
			}
			idleTimer = FlxG.random.int(1, 4);
		}
		else
			idleTimer -= elapsed;
	}

	public function chase(elapsed:Float)
	{
		if (!seesPlayer)
		{
			brain.activeState = idle;
		}
		else
		{
			// FlxVelocity.moveTowardsPoint(this, playerPosition, Std.int(SPEED));
			velocity.x = -SPEED / 4;
			velocity.y = 0;
		}
	}

	override public function update(elapsed:Float)
	{
		movement();
		brain.update(elapsed);
		super.update(elapsed);
	}
}
