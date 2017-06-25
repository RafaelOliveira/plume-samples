package objects;

import kha.graphics2.Graphics;
import plume.graphics.SpriteAnim;
import plume.atlas.Atlas;

class Fan
{
	public var x:Float;
	public var y:Float;
	var sprite:SpriteAnim;

	public function new(x:Float, y:Float):Void
	{
		this.x = x;
		this.y = y;

		var regions = Atlas.getRegionsByIndex('fan-anim', 1, 3);
		
		sprite = new SpriteAnim();
		sprite.addAnimation('on', regions);
		sprite.play('on');
	}

	inline public function update():Void
	{
		sprite.update();
	}

	inline public function render(g2:Graphics):Void
	{
		sprite.render(g2, x, y);
	}
}