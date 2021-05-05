package states;

import actors.Enemies;
import actors.Player;
import environment.DeathPit;
import environment.Goal;
import environment.LevelBounds;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player;
	private var enemies:FlxTypedGroup<Enemy>;
	private var goal:Goal;
	private var deathPit:DeathPit;
	private var levelBounds:LevelBounds;

	private var map:FlxOgmo3Loader;
	private var ground:FlxTilemap;
	private var background:FlxTilemap;
	private var foreground:FlxTilemap;
	private var snow:FlxTilemap;
	private var backgroundTrees:FlxTilemap;

	private var ending:Bool;
	private var won:Bool;

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

		enemies = new FlxTypedGroup<Enemy>();

		levelBounds = new LevelBounds(0, 0);
		levelBounds.setSize(1, 368);

		goal = new Goal(0, 0);
		goal.setSize(16, 128);

		deathPit = new DeathPit(0, 0);
		deathPit.setSize(1280, 16);
	}

	private function addEntities():Void
	{
		add(background);
		add(backgroundTrees);
		add(ground);

		add(player);
		add(enemies);
		add(levelBounds);
		add(goal);
		add(deathPit);
		add(foreground);
	}

	private function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);

			case "FlyingEye":
				enemies.add(new Enemy(x, y, FlyingEye));

			case "goal":
				goal.setPosition(x, y);

			case "deathPit":
				deathPit.setPosition(x, y);

			case "levelBounds":
				levelBounds.setPosition(x, y);
		}
	}

	function checkEnemyVision(enemy:Enemy)
	{
		if (enemy.isOnScreen())
		{
			enemy.seesPlayer = true;
			enemy.playerPosition = player.getMidpoint();
		}
		else
		{
			enemy.seesPlayer = false;
		}
	}

	function doneFadeOut()
	{
		FlxG.switchState(new GameOverState(won));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (ending)
		{
			return;
		}

		if (FlxG.overlap(player, goal))
		{
			won = true;
			ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, doneFadeOut);
		}
		else if (FlxG.overlap(player, deathPit) || FlxG.overlap(player, enemies))
		{
			won = false;
			ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, doneFadeOut);
		}

		FlxG.collide(player, ground);
		FlxG.collide(player, levelBounds);
		enemies.forEachAlive(checkEnemyVision);
	}
}
