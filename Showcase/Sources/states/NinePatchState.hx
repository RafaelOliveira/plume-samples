package states;

import kha.Assets;
import kha.graphics2.Graphics;
import plume.graphics.text.BitmapText;
import plume.graphics.text.Text.TextAlign;
import plume.Plm;
import objects.Panel;

class NinePatchState extends Play
{
	var panels:Array<Panel>;
	var text:BitmapText;

	public function new():Void
	{
		super('sprite', 'sprite');

		panels = new Array<Panel>();

		panels.push(new Panel('button1', 50, 50, 6, 6, 6, 6, 150, 200));
		panels.push(new Panel('button2', 250, 80, 7, 7, 11, 12, 300, 50));
		panels.push(new Panel('button3', 420, 200, 7, 7, 8, 8, 200, 100));
		panels.push(new Panel(Assets.images.button4, 180, 370, 5, 5, 10, 9, 250, 80));

		text = new BitmapText('NinePatch', 'Vera', Plm.gameWidth, { align: TextAlign.Center });
	}

	override function render(g2:Graphics):Void
	{
		super.render(g2);

		for (panel in panels)
			panel.render(g2);		

		text.render(g2, 0, 520);
	}
}