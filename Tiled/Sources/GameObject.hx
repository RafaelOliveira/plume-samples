package;

import kha.graphics2.Graphics;
import plume.atlas.Region;

class GameObject
{
	public var x:Float;
	public var y:Float;
	public var region:Region;

	public function new(x:Float, y:Float, regName:String):Void
	{
		this.x = x;
		this.y = y;
		region = Region.get(regName);		
	}

	public function render(g2:Graphics):Void
	{
		region.render(g2, x, y);
	}
}