package;

import ld.core.GameManager;
import lib.sro.core.Bezier;
import lib.sro.screen.ScreenController;
import lib.sro.ui.impl.AnimatedSprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Sebastien roelandt
 */
class Main extends Sprite 
{	
	public function init(e) 
	{
		if (ScreenController.ME != null) return;
		
		//Init root
		var gm = new GameManager();
		addChild(gm);
	}
		
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		#if ios
			haxe.Timer.delay(init, 100); // iOS 6
		#else
			init(e);
		#end
	}
	
	static function main()
	{
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}

}
