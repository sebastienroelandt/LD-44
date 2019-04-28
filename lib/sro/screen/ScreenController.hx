package lib.sro.screen;

import openfl.display.Sprite;
import openfl.display.Stage;
import lib.sro.layers.DebugLayer;
import openfl.Lib;
import openfl.events.Event;

/**
 * ...
 * @author Sebastien roelandt
 */
class ScreenController extends Sprite
{
	public static var ME:ScreenController;
	
	public var debugLayer:DebugLayer;

	private var currentScreen:Screen;
	private var nextScreens:Array<Screen>;
	
	private var lastTime:Float;
	
	public function new() 
	{
		super();
		if (ME != null) {
			throw "ScreenController must be initiate only one time.";
		}
		currentScreen = null;
		nextScreens = new Array<Screen>();
		debugLayer = new DebugLayer();
		
		this.addChild(debugLayer);
		
		ME = this;
		lastTime = Lib.getTimer();
	}
	
	public function start():ScreenController{
		this.addEventListener(Event.RESIZE, onStageResize);
		
		return this;
	}
	
	public function addScreen(screen:Screen) {
		if (screen != null) {
			if (currentScreen == null) {
				currentScreen = screen;
				loadCurrentScreen();
			} else {
				nextScreens.push(screen);
			}
		}
	}
	
	private function deletePreviousScreen() {
		if (currentScreen != null) {
			this.removeChild(currentScreen);
		}
	}
	
	private function loadCurrentScreen() {
		if (currentScreen != null) {
			this.addChild(currentScreen);
			resetDebugLayerPosition();
		}
	}
	
	public function nextScreen() {
		if (nextScreens.length > 0) {
			deletePreviousScreen();
			currentScreen = nextScreens.shift();
			loadCurrentScreen();
		}
	}
	
	public function getCurrentScreen():Screen {
		return currentScreen;
	}
	
	private function resetDebugLayerPosition() {
		this.setChildIndex(debugLayer, this.numChildren - 1);
	}
	
	///Update
	public function updateScreenSize() {
		//To do
	}
	
	public function update() {	
		if (currentScreen != null) {
			var delta = Lib.getTimer() - lastTime;
		
			currentScreen.updateAll(delta);
			debugLayer.updateAll(delta);
			
			lastTime = Lib.getTimer();
		}
	}
	
	//Event Control
	private function onStageResize(e){
		updateScreenSize();
	}
}