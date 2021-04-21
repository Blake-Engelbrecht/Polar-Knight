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
	var background:FlxTilemap;
	var foreground:FlxTilemap;
	var snow:FlxTilemap;
	var backgroundTrees:FlxTilemap;

	override public function create()
	{
		bgColor = 0xFF2E3440;

		map = new FlxOgmo3Loader("assets/data/polar-knight-testLevel.ogmo", "assets/data/testLevel.json");
		ground = map.loadTilemap("assets/images/pk-ground-tile.png", "ground");
		background = map.loadTilemap("assets/images/pk-background-tile.png", "background");
		foreground = map.loadTilemap("assets/images/pk-foreground-tile.png", "foreground");
		snow = map.loadTilemap("assets/images/pk-snow-tile.png", "snow");
		backgroundTrees = map.loadTilemap("assets/images/pk-tree-tile.png", "backgroundTrees");

		ground.follow();
		ground.setTileProperties(1, FlxObject.NONE);
		ground.setTileProperties(2, FlxObject.ANY);
		ground.setTileProperties(3, FlxObject.ANY);

		add(background);
		// add(snow);
		add(backgroundTrees);
		add(ground);

		player = new Player();
		player.setSize(30, 45);
		player.offset.set(78, 70);
		map.loadEntities(placeEntities, "entities"); // player spawn point position

		add(player);
		add(foreground);
		FlxG.camera.follow(player);

		super.create();
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
