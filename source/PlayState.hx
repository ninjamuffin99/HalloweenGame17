package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import openfl.display.BlendMode;

class PlayState extends FlxState
{
	private var _player:Player;
	private var bg:FlxSprite;
	
	private var _flashLight:Flashlight;
	private var _wall:FlxSprite;
	
	private var _darkness:FlxSprite;
	private var _darkness2:FlxSprite;
	
	override public function create():Void
	{
		
		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.bg__png, false, 689, 483);
		add(bg);
		
		_player = new Player(100, 100);
		add(_player);
		
		
		_darkness = new FlxSprite(0, 0);
		_darkness.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_darkness.blend = BlendMode.MULTIPLY;
		add(_darkness);
		
		_darkness2 = new FlxSprite();
		_darkness2 = _darkness.clone();
		
		
		_flashLight = new Flashlight(_player.x, _player.y);
		//_flashLight.blend = BlendMode.MULTIPLY;
		add(_flashLight);
		
		
		
		_wall = new FlxSprite(100, 100);
		_wall.makeGraphic(100, 100);
		_wall.health = 1;
		add(_wall);
		
		
		FlxG.camera.zoom = 2;
		FlxG.camera.follow(_player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		_flashLight.angle = _player.angle - 90;
		_flashLight.setPosition(_player.x - (_flashLight.width - _player.width) / 2, (_player.y + (_player.height - _flashLight.height) / 2));
		
		var rads = _flashLight.angle * Math.PI / 180;
		
		var xDir = Math.cos(rads);
		var yDir = Math.sin(rads);
		
		_flashLight.x += xDir* 35;
		_flashLight.y += yDir * 35;
		_flashLight.updateHitbox();
		_darkness.stamp(_darkness2, 0, 0);
		_darkness.stamp(_flashLight, Std.int(_player.x), Std.int(_player.y));
		if (FlxG.mouse.justPressed)
		{
			_flashLight.visible = !_flashLight.visible;
			Pew.shoot(_player.x, _player.y, FlxG.mouse.x, FlxG.mouse.y, [_wall]).health -= 0.1;
		}
		
		if (FlxG.mouse.pressed)
		{
			FlxG.watch.addQuick("RayCast", Pew.shoot(_player.x, _player.y, FlxG.mouse.x, FlxG.mouse.y, [_wall]));
			
			
		}
		_wall.alpha = _wall.health;
	}
}