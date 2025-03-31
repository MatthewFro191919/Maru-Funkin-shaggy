public var defaultCamZoom:Float = 1.05;
public static var curStage:String = '';

function createPost()
{

				defaultCamZoom = 0.8;
				curStage = 'out';
	
				var sky:BGElement = new BGElement('OBG/sky', -1204, -456, 0.15, 1, 0);
				add(sky);

				var clouds:BGElement = new BGElement('OBG/clouds', -988, -260, 0.25, 1, 1);
				add(clouds);

				var backMount:BGElement = new BGElement('OBG/backmount', -700, -40, 0.4, 1, 2);
				add(backMount);

				var middleMount:BGElement = new BGElement('OBG/middlemount', -240, 200, 0.6, 1, 3);
				add(middleMount);

				var ground:BGElement = new BGElement('OBG/ground', -660, 624, 1, 1, 4);
				add(ground);
}
