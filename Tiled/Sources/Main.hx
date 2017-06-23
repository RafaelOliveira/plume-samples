package;

import kha.Assets;
import kha.System;
import plume.Engine;
import plume.Plm;
import plume.atlas.Atlas;

class Main 
{
	public static function main() 
	{
		System.init({ title: 'Tiled', width: 800, height: 600 }, function () {
			Assets.loadEverything(assetsLoaded);
		});
	}

	static function assetsLoaded()
	{
		new Engine({ keyboard: true });
		Atlas.loadAtlasShoebox(Assets.images.textures, Assets.blobs.textures_xml);

		Plm.setState(new Play());
	}
}