package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

class GameOverState extends FlxState
{
	private var gameOverWin:FlxText;
	private var gameOverLose:FlxText;
	private var mainMenuButton:FlxButton;
	private var playerAlive:Bool;

	override public function create():Void
	{
		gameOverWin = new FlxText(0, 20, 0, "You Win!", 22);
		gameOverWin.alignment = CENTER;
		gameOverLose = new FlxText(0, 20, 0, "You Died!", 22);
		gameOverLose.alignment = CENTER;

		if (playerAlive)
		{
			add(gameOverWin);
		}
		else
		{
			add(gameOverLose);
		}

		super.create();
	}
}
