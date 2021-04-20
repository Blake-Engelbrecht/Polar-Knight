package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import player.Player;

class PlayState extends FlxState
{
	var levelBounds:FlxGroup;
	var player:Player;

	override public function create()
	{
		super.create();
		bgColor = 0xff2E3440;
		player = new Player(500, 200);

		add(player);
		levelBounds = FlxCollision.createCameraWall(FlxG.camera, true, 1);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, levelBounds);
	}
}
