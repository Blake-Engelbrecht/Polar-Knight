package environment;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Goal extends FlxObject
{
	public static var WIDTH(default, never):Int = 16;
	public static var HEIGHT(default, never):Int = 128;

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
