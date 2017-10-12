package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ninjaMuffin
 */
class Player extends FlxSprite 
{
	private var speed:Float = 100;
	private var interacting:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.WizardPlaceholder__png, false, 32, 32);
		
		centerOrigin();
		
		drag.x = drag.y = 700;
	}
	
	override public function update(elapsed:Float):Void 
	{
		rotation();
		controls();
		
		super.update(elapsed);
		
	}
	
	private function rotation():Void
	{
		var rads:Float = Math.atan2(FlxG.mouse.y - this.y, FlxG.mouse.x - this.x);
		FlxG.watch.addQuick("Rads", Math.atan2(FlxG.mouse.y - this.y, FlxG.mouse.x - this.x));
		
		var degs = rads * 180 / Math.PI;
		FlxG.watch.addQuick("Degs/Angle", degs);
		angle = degs + 90;
	}
	
	private function controls():Void
	{
		var _up = FlxG.keys.anyPressed([UP, W]);
		var _down = FlxG.keys.anyPressed([DOWN, S]);
		var _left = FlxG.keys.anyPressed([LEFT, A]);
		var _right = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if (_up || _down || _left || _right)
		{
			var mA:Float = 0;
			
			if (_up)
			{
				mA = -90;
				if (_left)
					mA -= 45;
				else if (_right)
					mA += 45;
				facing = FlxObject.UP;
			}
			else if (_down)
			{
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
				facing = FlxObject.DOWN;
			}
			else if (_left)
			{
				facing = FlxObject.LEFT;
				mA = 180;
			}
			else if (_right)
			{
				facing = FlxObject.RIGHT;
				mA = 0;
			}
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), mA);
			
			
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				switch(facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("walklr");
					case FlxObject.UP, FlxObject.DOWN:
						animation.play("walkud");
				}
			}
			
		}
	}
	
	public function interact(object:FlxSprite, _objAnimOnly:Bool,  _animationON:String = "", _animationOFF:String = "", sound:String = null, collision:Bool = false, objectOffset:Float = 0, Callback:Bool = false, CallbackFunc:Void->Void = null, callbackOnly:Bool = false):Void
	{
		var _btnInteract:Bool = false;
		_btnInteract = FlxG.keys.anyJustPressed([SPACE, W, E, I, O, UP]);
		
		var _btnUninteract:Bool = false;
		_btnUninteract = FlxG.keys.anyPressed([LEFT, A, J, RIGHT, D, L]);
		
		if (collision)
		{
			object.immovable = true;
			
			
			if (FlxG.collide(this, object) && _btnInteract)
			{
				object.animation.play(_animationON);
				FlxG.sound.play(sound);
					
				if (Callback)
				{
					FlxG.log.add("Interaction Callback");
					CallbackFunc();
				}
			}
		}
		else
		{
			if (FlxG.overlap(this, object))
			{
				
				if (_btnInteract && !interacting)
				{
					
					object.animation.play(_animationON);
					FlxG.sound.play(sound);
					
					if (Callback)
					{
						FlxG.log.add("Interaction Callback");
						CallbackFunc();
					}
					
					//change this so it calls a special function or something like sitdown if needed
					if (!_objAnimOnly)
					{
						visible = false;
						interacting = true;
					}
					//FlxG.sound.playMusic("assets/music/track1.mp3");
				}
				
				if (_btnUninteract && interacting)
				{
					object.animation.play(_animationOFF);
					interacting = false;
					visible = true;
				}
				
				if (interacting && !_objAnimOnly)
				{
					this.x = object.x + objectOffset;
				}
			}
		}
		
		
	}
	
	public function interactOneTime(object:FlxSprite, _objAnimOnly:Bool,  _animationON:String = "", _animationOFF:String = "", sound:String = null, collision:Bool = false, objectOffset:Float = 0, Callback:Bool = false, CallbackFunc:Void->Void = null, callbackOnly:Bool = false):Void
	{
		
		
		var _btnInteract:Bool = false;
		_btnInteract = FlxG.keys.anyJustPressed([SPACE, E, O]);
		
		/*
		var _btnUninteract:Bool = false;
		_btnUninteract = FlxG.keys.anyPressed([LEFT, A, J, RIGHT, D, L]);
		*/
		if (collision)
		{
			object.immovable = true;
			
			
			if (FlxG.collide(this, object) && _btnInteract)
			{
				object.animation.play(_animationON);
				FlxG.sound.play(sound);
					
				if (Callback)
				{
					FlxG.log.add("Interaction Callback");
					CallbackFunc();
				}
			}
		}
		else
		{
			if (FlxG.overlap(this, object))
			{
				
				if (_btnInteract && !interacting)
				{
					
					object.animation.play(_animationON);
					FlxG.sound.play(sound);
					
					if (Callback)
					{
						FlxG.log.add("Interaction Callback");
						CallbackFunc();
					}
					
					//FlxG.sound.playMusic("assets/music/track1.mp3");
				}
				/*
				if (_btnUninteract && interacting)
				{
					object.animation.play(_animationOFF);
					interacting = false;
					visible = true;
				}
				*/
				if (interacting && !_objAnimOnly)
				{
					this.x = object.x + objectOffset;
				}
			}
		}
		
		
	}
	
}