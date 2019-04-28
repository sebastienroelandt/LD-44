package lib.sro.ui.impl;

import openfl.display.Bitmap;
import lib.sro.ui.impl.BasicUI;
import lib.sro.input.Mouse;
import openfl.display.BitmapData;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
enum ButtonState {
	Default;
	Hover;
	Press;
}
 
class ButtonUI extends BasicUI
{
	
	//Default
	private var defaultBitmapData:BitmapData;
	//Hover
	private var hoverBitmapData:BitmapData;
	//Press
	private var pressBitmapData:BitmapData;
	
	private var isPress:Bool;
	private var currentBitmap:Bitmap;
	private var currentState:ButtonState;
	
	public function new(x:Float, y:Float, defaultBitmapData:BitmapData, ?hoverBitmapData:BitmapData, ?pressBitmapData:BitmapData) 
	{
		super();
		this.defaultBitmapData = defaultBitmapData;
		this.hoverBitmapData = hoverBitmapData == null ? defaultBitmapData: hoverBitmapData;
		this.pressBitmapData = pressBitmapData == null ? defaultBitmapData: pressBitmapData;
		this.isPress = false;
		this.currentState = ButtonState.Default;
		this.currentBitmap = new Bitmap();
		this.currentBitmap.bitmapData = defaultBitmapData;
		this.currentBitmap.x = x;
		this.currentBitmap.y = y;
		this.addChild(this.currentBitmap);
	}
	
	override public function update(delta:Float) {	
		updateButtonState();
	}
	
	private function updateButtonState() {
		var previousState = currentState;
		
		//update
		if (isMouseIn()) {
			if (Mouse.isEndClick() && isPress) {
				onClick();
				isPress = false;
				currentState = ButtonState.Hover;
			}
			if (Mouse.isBeginClick()) {
				isPress = true;
				currentState = ButtonState.Press;
			}
			if (!Mouse.isDown()) {
				isPress = false;
				currentState = ButtonState.Hover;
			}
		} else {
			if (!Mouse.isDown()) {
				isPress = false;
				currentState = ButtonState.Default;
			}
		}
		
		if (previousState != currentState) {
			onNewState();
			switch (currentState) {
				case ButtonState.Press 	: currentBitmap = pressBitmapData;
				case ButtonState.Hover 	: currentBitmap = hoverBitmapData;
				default					: currentBitmap = defaultBitmapData;					
			}
		}
	}
	
	private function isMouseIn():Bool {
		var point = Mouse.getXY();
		return point.x >= this.currentBitmap.x 
				&& point.x <= this.currentBitmap.x + this.currentBitmap.width
				&& point.y >= this.currentBitmap.y 
				&& point.y <= this.currentBitmap.y + this.currentBitmap.height;
	}
		
	public function onClick() {
		//onClick Event
		trace("click on Button");
	}
	
	public function onNewState() {
		//change Event
	}
}