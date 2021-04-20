package states;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;


class MenuState extends FlxState
{
    var PlayButton:FlxButton;

	override public function create() {		
        PlayButton = new FlxButton(0, 0, "Play", clickPlay);
        add(PlayButton);
        PlayButton.screenCenter();

        super.create();
	}

    function clickPlay() {
        FlxG.switchState(new PlayState());
        
    }

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
