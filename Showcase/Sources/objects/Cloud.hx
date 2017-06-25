package objects;

import kha.graphics2.Graphics;
import plume.atlas.Region;
import plume.Plm;

class Cloud
{
	public var x:Float;
	public var y:Float;

	var scrollX:Float;
	var alpha:Float;
	var region:Region;

	public function new(x:Float, y:Float, scrollX:Float, alpha:Float = 1):Void
	{
		this.x = x;
		this.y = y;
		this.scrollX = scrollX;
		this.alpha = alpha;

		region = Region.get('cloud');
	}

	public function update():Void
	{
		x += scrollX;

		if (x < 0 && scrollX < 0)
			x = Plm.gameWidth;
		else if (x > Plm.gameWidth && scrollX > 0)
			x = -region.width;
	}

	inline public function render(g2:Graphics):Void
	{
		g2.pushOpacity(alpha);
		region.render(g2, x, y);
		g2.popOpacity();
	}
}