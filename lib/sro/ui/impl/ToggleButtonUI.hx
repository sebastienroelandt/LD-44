package lib.sro.ui.impl;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import lib.sro.ui.impl.BasicUI;
import lib.sro.input.Mouse;

/**
 * ...
 * @author Sebastien roelandt
 */

enum ToggleButtonState {
	Left;
	Right;
}
 
class ToggleButtonUI extends BasicUI
{

	//Left
	private var leftBitmap:Bitmap;
	private var defaultLeftBitmapData:BitmapData;
	private var activeLeftBitmapData:BitmapData;
	
	//Right
	private var rightBitmap:Bitmap;
	private var defaultRightBitmapData:BitmapData;
	private var activeRightBitmapData:BitmapData;
	
	private var isPress:Bool;
	private var currentState:ToggleButtonState;
	
	public function new(x:Float, y:Float, leftBitmapData:BitmapData, rightBitmapData:BitmapData, 
		?leftActiveBitmapData:BitmapData = null, ?rightActiveBitmapData:BitmapData = null, ?delta:Float = 0) 
	{
		super();
		this.defaultLeftBitmapData = leftBitmapData;
		this.activeLeftBitmapData = leftActiveBitmapData == null ? defaultLeftBitmapData: leftActiveBitmapData;
		this.defaultRightBitmapData = rightBitmapData;
		this.activeRightBitmapData = rightActiveBitmapData == null ? defaultRightBitmapData: rightActiveBitmapData;

		this.isPress = false;
		this.currentState = ToggleButtonState.Left;
		
		this.rightBitmap = new Bitmap();
		this.rightBitmap.bitmapData = defaultRightBitmapData;
		this.rightBitmap.x = x + delta;
		this.rightBitmap.y = y;
		if (delta == 0) {
			this.rightBitmap.visible = false;
		}
		this.addChild(this.rightBitmap);
		
		this.leftBitmap = new Bitmap();
		this.leftBitmap.bitmapData = activeLeftBitmapData;
		this.leftBitmap.x = x;
		this.leftBitmap.y = y;
		if (delta == 0) {
			this.leftBitmap.visible = true;
		}
		this.addChild(this.leftBitmap);
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
				inverseStates();
			}
			if (Mouse.isBeginClick()) {
				isPress = true;
			}
			if (!Mouse.isDown()) {
				isPress = false;
			}
		} else {
			if (!Mouse.isDown()) {
				isPress = false;
			}
		}
	}
	
	public function inverseStates() {
		if (currentState == ToggleButtonState.Left) {
			currentState = ToggleButtonState.Right;
			this.leftBitmap.bitmapData = defaultLeftBitmapData;
			this.rightBitmap.bitmapData = activeRightBitmapData;
			this.leftBitmap.visible = false;
			this.rightBitmap.visible = true;
		} else {
			currentState = ToggleButtonState.Left;
			this.leftBitmap.bitmapData = activeLeftBitmapData;
			this.rightBitmap.bitmapData = defaultRightBitmapData;
			this.leftBitmap.visible = true;
			this.rightBitmap.visible = false;
		}
		inverseIndex();
	}
	
	private function isMouseIn():Bool {
		var point = Mouse.getXY();
		return (point.x >= this.leftBitmap.x 
				&& point.x <= this.leftBitmap.x + this.leftBitmap.width
				&& point.y >= this.leftBitmap.y 
				&& point.y <= this.leftBitmap.y + this.leftBitmap.height )
			|| (point.x >= this.rightBitmap.x 
				&& point.x <= this.rightBitmap.x + this.rightBitmap.width
				&& point.y >= this.rightBitmap.y 
				&& point.y <= this.rightBitmap.y + this.rightBitmap.height );
	}
		
	public function onClick() {
		//onClick Event
		trace ("click on ToggleButton");
	}
	
	public function inverseIndex() {
		var leftIndex = this.getChildIndex(leftBitmap);
		var rightIndex = this.getChildIndex(rightBitmap);
		var min = leftIndex > rightIndex ? rightIndex : leftIndex;
		var max = leftIndex < rightIndex ? rightIndex : leftIndex;
		if (currentState == ToggleButtonState.Right) {
			this.setChildIndex(leftBitmap, min);
			this.setChildIndex(rightBitmap, max);
		} else{
			this.setChildIndex(rightBitmap, min);
			this.setChildIndex(leftBitmap, max);
		}
	}
}