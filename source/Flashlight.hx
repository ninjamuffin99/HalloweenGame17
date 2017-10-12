package;

using flixel.util.FlxSpriteUtil;

import flash.display.BlendMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author ninjaMuffin
 */
class Flashlight extends FlxSpriteGroup 
{
	private var _darkness:FlxSprite;
	private var _objectTest:FlxSprite;

	public function new(_playerX:Float, _playerY:Float) 
	{
		super();
		/*
		_darkness = new FlxSprite(0, 0);
		_darkness.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_darkness.blend = BlendMode.MULTIPLY;
		_darkness.alpha = 0.5;
		add(_darkness);
		*/
		_objectTest = new FlxSprite();
		_objectTest.makeGraphic(40, 16);
		//_objectTest.blend = BlendMode.SCREEN;
		add(_objectTest);
		
		
	}
	
}