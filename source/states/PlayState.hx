package states;

import player.Player;
import flixel.FlxState;

class PlayState extends FlxState {

	override public function create() {		
		super.create();
		bgColor = 0xff2E3440;
		final player = new Player();
		add(player);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
