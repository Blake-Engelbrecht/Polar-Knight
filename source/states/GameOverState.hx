package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class GameOverState extends FlxState
{
	var win:Bool;
	var titleText:FlxText;
	var mainMenuButton:FlxButton;

	public function new(win:Bool)
	{
		super();
		this.win = win;
	}

	override public function create()
	{
		FlxG.mouse.visible = true;

		titleText = new FlxText(0, 20, 0, if (win) "You Win!" else "You Died!", 22);
		titleText.alignment = CENTER;
		titleText.screenCenter(FlxAxes.X);
		add(titleText);

		mainMenuButton = new FlxButton(0, FlxG.height - 32, "Main Menu", switchToMainMenu);
		mainMenuButton.screenCenter(FlxAxes.X);
		add(mainMenuButton);

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	private function switchToMainMenu():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}
}
