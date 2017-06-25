package states;

import kha.Color;
import kha.graphics2.Graphics;
import plume.State;
import plume.Plm;
import plume.graphics.text.BitmapText;
import plume.graphics.text.Text.TextAlign;
import objects.GameObject;
import objects.Fan;

class SpriteState extends Play
{
	var objects:Array<GameObject>;
	var fan:Fan;
	var text:BitmapText;

	public function new():Void
	{
		super('ninepatch', 'ninepatch');

		objects = new Array<GameObject>();

		objects.push(new GameObject(200, 300, 'obj_crate001'));
		objects.push(new GameObject(objects[0].x + objects[0].width, objects[0].y, 'obj_crate002'));
		objects.push(new GameObject(objects[1].x + objects[1].width, objects[0].y, 'obj_crate003'));
		objects.push(new GameObject(objects[2].x + objects[2].width, objects[0].y, 'obj_crate004'));
		objects.push(new GameObject(objects[0].x + 100, objects[0].y - 84, 'obj_cookiejar001'));

		fan = new Fan(objects[0].x + 200, objects[0].y - 91);
		text = new BitmapText('Sprites', 'Vera', Plm.gameWidth, { align: TextAlign.Center });
	}

	override function update():Void
	{
		super.update();

		fan.update();
	}

	override function render(g2:Graphics):Void
	{
		super.render(g2);
		
		for (obj in objects)
			obj.render(g2);

		fan.render(g2);

		text.render(g2, 0, 520);
	}
}