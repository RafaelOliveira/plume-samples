package objects;

import kha.graphics2.Graphics;
import plume.graphics.NinePatch;
import plume.atlas.Atlas.ImageType;

class Panel
{
	public var x:Float;
	public var y:Float;
	
	var np:NinePatch;

	public function new(source:ImageType, x:Float, y:Float, leftBorder:Int, rightBorder:Int, topBorder:Int, bottomBorder:Int, width:Int, height:Int):Void
	{
		this.x = x;
		this.y = y;
		np = new NinePatch(source, leftBorder, rightBorder, topBorder, bottomBorder, width, height);
	}

	inline public function render(g2:Graphics):Void
	{
		np.render(g2, x, y);
	}	
}