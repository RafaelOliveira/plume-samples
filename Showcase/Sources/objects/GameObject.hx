package objects;

import kha.graphics2.Graphics;
import plume.atlas.Region;

class GameObject
{
	public var x:Float;
	public var y:Float;
	public var width(get, null):Int;
	public var height(get, null):Int;

	public var region:Region;

	public function new(x:Float, y:Float, regName:String):Void
	{
		this.x = x;
		this.y = y;
		region = Region.get(regName);		
	}

	inline public function render(g2:Graphics):Void
	{
		region.render(g2, x, y);
	}

	inline function get_width():Int
	{
		return region.width;
	}

	inline function get_height():Int
	{
		return region.height;
	}
}