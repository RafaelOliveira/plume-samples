package;

import kha.Assets;
import kha.System;
import plume.Engine;
import plume.Plm;
import plume.atlas.Atlas;
import plume.graphics.text.BitmapText;
import states.SpriteState;
import states.NinePatchState;

class Main 
{
	public static function main() 
	{
		System.init({ title: 'Showcase', width: 800, height: 600 }, function () {
			Assets.loadEverything(assetsLoaded);
		});
	}

	static function assetsLoaded()
	{
		new Engine({ keyboard: true, mouse: true });

		// load atlas

		Atlas.loadAtlasShoebox(Assets.images.textures, Assets.blobs.textures_xml);

		// create additional regions from the images

		var regsFanAnim = Atlas.createRegionList('obj_fan001', 84, 96);
		Atlas.saveRegionList(regsFanAnim, 'fan-anim');

		var regCloud = Atlas.createRegion(Assets.images.tileset, 0, 544, 160, 64);
		Atlas.saveRegion(regCloud, 'cloud');

		// load bitmap fonts

		BitmapText.loadFont('Vera', Assets.images.vera, Assets.blobs.vera_fnt);
		BitmapText.loadFont('AlexBrush', 'AlexBrush', Assets.blobs.AlexBrush_fnt);
		BitmapText.loadFont('Oswald', Assets.images.oswald, Assets.blobs.oswald_fnt);
		BitmapText.loadFont('Pacifico', Assets.images.pacifico, Assets.blobs.pacifico_fnt);

		Plm.addState(new SpriteState(), 'sprite', true);
		Plm.addState(new NinePatchState(), 'ninepatch');
	}
}
