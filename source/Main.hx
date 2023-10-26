package;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	var game = {
		width: 1280, 					// Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
		height: 720, 					// Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
		initialState:					// The FlxState the game starts with.
		#if PRELOAD_ALL	funkin.Preloader
		#else			SplashState	#end,
		//funkin.states.TestingState,
		zoom: -1.0, 					// If -1, zoom is automatically calculated to fit the window dimensions.
		framerate: 60, 					// How many frames per second the game should run at.
		skipSplash: true, 				// Whether to skip the flixel splash screen that appears in release mode.
		startFullscreen: false 			// Whether to start the game in fullscreen on desktop targets
	};

	public static var fpsCounter:FPS_Mem; //The FPS display child
	public static var scriptConsole:ScriptConsole;
	public static var engineVersion(default, never):String = "1.0.0-b.1"; //The engine version, if its not the same as the github one itll open OutdatedSubState

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
	}

	static function uncaughtError(error:UncaughtErrorEvent) {
		Application.current.window.alert(Std.string(error.error), "Uncaught Error");
		DiscordClient.shutdown();
		Sys.exit(1);
	}

	public function new()
	{
		super();
		stage != null ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}

		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		scriptConsole = new funkin.ScriptConsole();
		addChild(scriptConsole);

		#if !mobile
		fpsCounter = new FPS_Mem(10,10,0xffffff);
		addChild(fpsCounter);
		#end
	}
}