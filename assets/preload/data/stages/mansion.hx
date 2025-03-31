public var defaultCamZoom:Float = 1.05;
public static var curStage:String = '';

function createPost()
{
				defaultCamZoom = 0.9;
				curStage = 'mansion';

				var bg:FlxSprite = new FlxSprite(-400, -160).loadGraphic(Paths.image('bg_lemon'));
				bg.setGraphicSize(Std.int(bg.width * 1.5));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.95, 0.95);
				bg.active = false;
				add(bg);
}
