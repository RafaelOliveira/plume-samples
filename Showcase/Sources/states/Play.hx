package states;

import kha.Color;
import kha.graphics2.Graphics;
import kha.input.KeyCode;
import plume.State;
import plume.Plm;
import plume.input.Keyboard;
import objects.Arrow;

class Play extends State
{
	var leftScreen:String;
	var rightScreen:String;
	
	var arrowLeft:Arrow;
	var arrowRight:Arrow;

	// Used to prevent the controls to switch screen
	// to not affect player controls
	var enableArrowKeys:Bool;

	var keyb = Keyboard.get();

	public function new(leftScreen:String, rightScreen:String, enableArrowKeys:Bool = true):Void
	{
		super();

		this.leftScreen = leftScreen;
		this.rightScreen = rightScreen;

		arrowLeft = new Arrow(20, 520, true, function() Plm.switchState(leftScreen));
		arrowRight = new Arrow(Plm.gameWidth - 50, 520, false, function() Plm.switchState(rightScreen));

		this.enableArrowKeys = enableArrowKeys;		
	}

	override function update():Void
	{
		arrowLeft.update();
		arrowRight.update();

		if (enableArrowKeys)
		{
			if (keyb.isPressed(KeyCode.Left))
				Plm.switchState(leftScreen);
			else if (keyb.isPressed(KeyCode.Right))
				Plm.switchState(rightScreen);
		}
	}

	override function render(g2:Graphics):Void
	{
		g2.clear(Color.Black);

		arrowLeft.render(g2);
		arrowRight.render(g2);

		g2.color = Color.White;
	}
}