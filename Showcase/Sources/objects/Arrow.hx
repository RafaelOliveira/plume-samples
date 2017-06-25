package objects;

import kha.Color;
import kha.graphics2.Graphics;
import plume.Plm;
import plume.graphics.Sprite;
import plume.input.Mouse;

class Arrow
{
	public var x:Float;
	public var y:Float;

	var sprite:Sprite;
	var color:Color;
	var onClick:Void->Void;

	var mouse = Mouse.get();

	public function new(x:Float, y:Float, left:Bool, onClick:Void->Void, scale:Float = 1.0):Void
	{
		this.x = x;
		this.y = y;

		sprite = new Sprite('arrow');
		sprite.setScale(scale, scale);
		sprite.flipX = left;

		this.onClick = onClick;
		color = Color.Red;		
	}

	public function update()
	{
		if (mouse.inRect(x, y, sprite.width, sprite.height))
		{
			color = 0xffff9393;

			if (mouse.isPressed())
				onClick();
		}
		else
			color = Color.Red;		
	}

	public function render(g2:Graphics):Void
	{
		g2.color = color;
		sprite.render(g2, x, y);
	}
}