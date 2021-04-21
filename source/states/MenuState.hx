package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var PlayButton:FlxButton;

	override public function create()
	{
		PlayButton = new FlxButton(0, 0, "Play", clickPlay);
		add(PlayButton);
		PlayButton.screenCenter();

		super.create();

		var text = new flixel.text.FlxText(80, 10, 0, "Polar Knight", 20);
		add(text);
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
