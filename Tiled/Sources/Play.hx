package;

import kha.Assets;
import kha.math.Vector2;
import kha.graphics2.Graphics;
import plume.State;
import plume.graphics.Tileset;
import plume.graphics.Tilemap;
import plume.graphics.TileSprite;
import plume.tools.FormatTmx;
import plume.collision.Grid;
import plume.collision.Body;
import plume.math.Rectangle;
import format.tmx.Data.TmxObjectType;
import format.tmx.Data.TmxObject;

/*
	Rendering order:

	bg
	objectsBg
	player
	objectsMiddle (collision)
	water
	tilemap (bgMap)
	objectsFg
*/

class Play extends State
{
	var bgMap:Tilemap;
	var objectsFg:Array<GameObject>;
	var objectsBg:Array<GameObject>;
	var objectsMiddle:Array<GameObject>;
	var water:TileSprite;

	var player:Player;
	
	public var collisionList:Array<Body>;

	public static var instance:Play;

	public function new():Void
	{
		super();

		instance = this;

		loadMap();
		water = new TileSprite('Water', 316, 54, 1, 0);
		player = new Player(70, 120);		
	}

	inline public static function getInstance():Play
	{
		return instance;
	}

	inline function loadMap():Void
	{
		var tileset = new Tileset('tileset', 128, 128);
		var tmx = new FormatTmx(Assets.blobs.map_tmx, true);
		var idsTiledObjs = tmx.getTileGidsFromTileset('objects');

		bgMap = new Tilemap(tileset);
		bgMap.loadFrom2DArray(tmx.tiles.get('collision'));
		setWorldSize(bgMap.width, bgMap.height);
		
		objectsFg = new Array<GameObject>();
		objectsBg = new Array<GameObject>();
		objectsMiddle = new Array<GameObject>();

		collisionList = new Array<Body>();
		
		loadObjects(tmx.objects.get('objects_fg'), objectsFg, idsTiledObjs, false);
		loadObjects(tmx.objects.get('objects_bg'), objectsBg, idsTiledObjs, false);
		loadObjects(tmx.objects.get('objects_collision'), objectsMiddle, idsTiledObjs, true);

		var grid = new Grid(new Vector2(), 128, 128);
		grid.loadEmpty(bgMap.columns, bgMap.rows);
		
		grid.setArea(0, 4, 3, 1, true);
		grid.setArea(5, 4, 10, 1, true);
		grid.setArea(7, 3, 2, 1, true);

		// this is a rect for the floating platforms
		// because the height is smaller		
		var rectTile = new Rectangle(0, 0, 128, 66);

		// first platform
		grid.setColRect(2, 1, rectTile);
		grid.setColRect(3, 1, rectTile);
		grid.setColRect(4, 1, rectTile);

		// second platform
		grid.setColRect(10, 1, rectTile);
		grid.setColRect(11, 1, rectTile);

		collisionList.push(grid);
	}

	function loadObjects(tiledObjs:Array<TmxObject>, list:Array<GameObject>, ids:Map<Int, String>, collision:Bool):Void
	{
		for (obj in tiledObjs)
		{
			switch(obj.objectType)
			{
				case TmxObjectType.Tile(gid):
					var regionName = StringTools.replace(ids.get(gid), 'images/', '');
					list.push(new GameObject(obj.x, obj.y, regionName));

					if (collision)
						collisionList.push(new Body(new Vector2(obj.x, obj.y), new Rectangle(0, 0, obj.width, obj.height)));
				
				default:
					continue;
			}
		}
	}

	override public function update():Void
	{
		player.update();
		water.update();
	}

	override public function render(g2:Graphics):Void
	{
		g2.drawImage(Assets.images.bg, 0, 0);

		camera.begin(g2);

		for (obj in objectsBg)
			obj.render(g2);
		
		player.render(g2);

		for (obj in objectsMiddle)
			obj.render(g2);

		water.render(g2, 355, 560);
		
		bgMap.renderInCamera(g2, 0, 0, camera);

		for (obj in objectsFg)
			obj.render(g2);

		camera.end(g2);
	}
}