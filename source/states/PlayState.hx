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
	private var player:Player;

	private var map:FlxOgmo3Loader;
	private var ground:FlxTilemap;
	private var background:FlxTilemap;
	private var foreground:FlxTilemap;
	private var snow:FlxTilemap;
	private var backgroundTrees:FlxTilemap;

	override public function create():Void
	{
		instantiateEntities();
		setUpLevel();
		addEntities();

		FlxG.camera.follow(player);

		super.create();
	}

	private function setUpLevel():Void
	{
		bgColor = 0xFF161c28;

		map = new FlxOgmo3Loader("assets/data/polar-knight-testLevel.ogmo", "assets/data/level01.json");
		ground = map.loadTilemap("assets/images/environment/pk-ground-tile.png", "ground");
		background = map.loadTilemap("assets/images/environment/pk-background-tile.png", "background");
		foreground = map.loadTilemap("assets/images/environment/pk-foreground-tile.png", "foreground");
		snow = map.loadTilemap("assets/images/environment/pk-snow-tile.png", "snow");
		backgroundTrees = map.loadTilemap("assets/images/environment/pk-tree-tile.png", "backgroundTrees");

		ground.follow();
		ground.setTileProperties(1, FlxObject.NONE);
		ground.setTileProperties(2, FlxObject.ANY);
		ground.setTileProperties(3, FlxObject.ANY);

		map.loadEntities(placeEntities, "entities"); // player spawn point position
	}

	private function instantiateEntities():Void
	{
		player = new Player();
		player.setSize(30, 45);
		player.offset.set(78, 70);
	}

	private function addEntities():Void
	{
		add(background);
		// add(snow);
		add(backgroundTrees);
		add(ground);

		add(player);
		add(foreground);
	}

	private function placeEntities(entity:EntityData)
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
