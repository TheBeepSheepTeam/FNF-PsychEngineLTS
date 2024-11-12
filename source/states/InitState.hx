package states;

import backend.WeekData;
import backend.Highscore;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import states.StoryMenuState;

class InitState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	override public function create():Void
	{
		Paths.clearStoredMemory();

		// FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		_doSetup();

		FlxG.mouse.visible = false;

		if (FlxG.save.data.flashing == null && !FlashingState.leftState)
		{
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		}
		MusicBeatState.switchState(new TitleState());
	}

	function _doSetup()
	{
		ClientPrefs.loadPrefs();
        Language.reloadPhrases();

		if (FlxG.save.data != null && ClientPrefs.data.fullscreen)
			FlxG.fullscreen = ClientPrefs.data.fullscreen;
		if (FlxG.save.data.weekCompleted != null)
			states.StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
	}
}
