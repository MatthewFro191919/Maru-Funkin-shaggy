public var defaultCamZoom:Float = 1.05;
public static var curStage:String = '';

function createPost()
{
				defaultCamZoom = 0.56;
				if (SONG.song != 'Astral-calamity') defaultCamZoom = 0.6;

				curStage = 'lava';

				var bgbg:BGElement = new BGElement('WBG/BGBG', -1940, -1112, 0.5, 1, 0);
				add(bgbg);

				var lavaLimits:BGElement = new BGElement('WBG/LavaLimits', -1770, 168, 0.55, 1, 1);
				add(lavaLimits);

				var bgSpikes:BGElement = new BGElement('WBG/BGSpikes', 112, -36, 0.6, 1, 2);
				add(bgSpikes);

				var spikes:BGElement = new BGElement('WBG/Spikes', -1186, -234, 0.8, 1, 3);
				add(spikes);

				var ground:BGElement = new BGElement('WBG/Ground', -1320, 590, 1, 1, 4);
				add(ground);
}
