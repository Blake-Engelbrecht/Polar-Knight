package environment;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class DeathPit extends FlxObject
{
	public static var WIDTH(default, never):Int = 80;
	public static var HEIGHT(default, never):Int = 16;

	public function new(xPos:Float, yPos:Float)
	{
		super(xPos, yPos);
		immovable = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
