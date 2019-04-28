package lib.sro.core;

import lib.sro.screen.ScreenController;
import lib.sro.core.ResourcesStorage;
import lib.sro.input.*;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.Lib;

import lib.sro.engine.*;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameController extends ScreenController
{
	public static var assets:ResourcesStorage;

	public function new() 
	{
		super();
		
		Keys.init();
		Mouse.init();
	}
	
	public override function start():GameController {		
		super.start();
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseKeyUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseKeyDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onScroll);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		return this;
	}
	
	///Update control
	override public function update() 
	{
		super.update();
		
		Mouse.reset();
		Keys.reset();
	}
	
	///Event control
	private function onKeyDown(event:KeyboardEvent) {
		Keys.onKeyDown(event);
	}
	
	private function onKeyUp(event:KeyboardEvent) {
		Keys.onKeyUp(event);
	}
	
	private function onMouseKeyDown(event:MouseEvent) {
		Mouse.onKeyDown(event);
	}
	
	private function onMouseKeyUp(event:MouseEvent) {
		Mouse.onKeyUp(event);
	}
	
	private function onMouseMove(event:MouseEvent) {
		Mouse.onMove(event);
	}
	
	private function onScroll(event:MouseEvent) {
		Mouse.onScroll(event);
	}
	
	private function onEnterFrame(e) {
		update();
	}
	
}