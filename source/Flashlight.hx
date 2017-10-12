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
class Flashlight extends FlxSprite
{
	//private var _darkness:FlxSprite;
	private var _objectTest:FlxSprite;

	public function new(_playerX:Float, _playerY:Float) 
	{
		super();
		
		makeGraphic(40, 35);
		blend = BlendMode.SCREEN;
		
	}
	
}