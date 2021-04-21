package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import player.Player;

class PlayState extends FlxState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var ground:FlxTilemap;

	override public function create()
	{
		super.create();

		map = new FlxOgmo3Loader("assets/data/polar-knight-testLevel.ogmo", "assets/data/testLevel.json");
		ground = map.loadTilemap("assets/images/pk-ground-tile.png", "ground");
		ground.follow();
		ground.setTileProperties(1, FlxObject.ANY);
		add(ground);

		player = new Player();
		player.setSize(30, 45);
		player.offset.set(78, 70);
		map.loadEntities(placeEntities, "entities");

		add(player);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(player, ground);
		super.update(elapsed);
	}
}
