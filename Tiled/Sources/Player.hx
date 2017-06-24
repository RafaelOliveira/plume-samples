package;

import kha.math.Vector2;
import kha.Assets;
import kha.input.KeyCode;
import kha.graphics2.Graphics;
import plume.graphics.SpriteAnim;
import plume.atlas.Atlas;
import plume.atlas.Region;
import plume.components.Motion;
import plume.input.Keyboard;
import plume.collision.Body;
import plume.math.Rectangle;
import plume.Plm;

class Player
{
	public var pos:Vector2;	
	var sprite:SpriteAnim;
	var motion:Motion;
	var body:Body;
	var onGround:Bool;
	var scaled:Bool;

	// half width		
	var hw:Int;	

	var keyb:Keyboard;
	var play:Play;
	
	public function new(x:Float, y:Float):Void
	{	
		var regions = Atlas.createRegionList(Assets.images.player, 92, 136);	
		setupAnimations(regions);

		pos = new Vector2(x, y);

		body = new Body(pos, new Rectangle(0, 0, sprite.width, sprite.height));
		body.moveCollideY = moveCollideY;

		hw = Std.int(sprite.width / 2);		

		motion = new Motion();
		motion.drag.x = 0.5;
		motion.maxVelocity.x = 5;
		motion.acceleration.y = 0.3;

		onGround = false;	
		scaled = false;

		keyb = Keyboard.get();
		play = Play.getInstance();
	}

	inline function setupAnimations(regions:Array<Region>):Void
	{
		sprite = new SpriteAnim();
		sprite.addAnimation('idle', regions.slice(0, 10));
		sprite.addAnimation('run', regions.slice(10, 20), 14);		

		sprite.play('idle');		
	}

	public function update():Void
	{
		motion.acceleration.x = 0;

		if (keyb.isDown(KeyCode.Left))
		{
			motion.acceleration.x = -0.7;
			sprite.flipX = true;	
		}            
        else if (keyb.isDown(KeyCode.Right))
		{		
			motion.acceleration.x = 0.7;
			sprite.flipX = false;
		}

		if ((keyb.isPressed(KeyCode.Z) || keyb.isPressed(KeyCode.Up)) && onGround)
		{
			motion.velocity.y = -9;
			onGround = false;
		}
		else if (keyb.isPressed(KeyCode.R))
		{
			onGround = false;
			pos.x = 70;
			pos.y = 120;
		}
		else if (keyb.isPressed(KeyCode.S))
		{
			if (!scaled)
			{
				sprite.width *= 2;
				sprite.height *= 2;
				body.rect.width *= 2;
				body.rect.height *= 2;
				pos.y -= (sprite.height / 2);

				scaled = true;
			}
			else
			{
				sprite.width = Std.int(sprite.width / 2);
				sprite.height = Std.int(sprite.height / 2);
				body.rect.width = Std.int(body.rect.width / 2);
				body.rect.height = Std.int(body.rect.height / 2);
				pos.y += sprite.height;

				scaled = false;
			}
		}

		motion.update();
		body.moveBy(motion.velocity.x, motion.velocity.y, play.collisionList, true);

		if (motion.velocity.x != 0 && sprite.nameAnim != 'run')
			sprite.play('run');
		else if (motion.velocity.x == 0 && sprite.nameAnim != 'idle')
			sprite.play('idle');

		sprite.update();

		if (pos.x < 0)
			pos.x = 0;
		else if ((pos.x + sprite.width) > Plm.state.worldWidth)
			pos.x = Plm.state.worldWidth - sprite.width;

		if (pos.y > Plm.gameHeight)
			pos.y = -sprite.height;
		
		Plm.camera.follow(pos.x + hw, 0);		
	}

	function moveCollideY(body:Body):Bool
	{
		if (motion.velocity.y > 0)
		{
			onGround = true;
			motion.velocity.y = 0;
		}		

		return true;
	}	

	inline public function render(g2:Graphics):Void
	{
		sprite.render(g2, pos.x, pos.y);
	}
}