package lib.sro.ui.impl;

import lib.sro.ui.impl.BasicUI;
import openfl.text.TextField;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class TextAnimation extends BasicUI
{
	private var	speed 			:Float;	
	private var nextCharTime	:Float;
	private var outputText		:String;
	private var textField		:TextField;
	private var finished		:Bool;

	public function new(outputText:String, textField:TextField, ?speed:Float = 100, ?parent:BasicUI=null) 
	{
		this.pause = true;
		super(parent);
		
		this.outputText = "";
		if (outputText != null) {
			this.outputText = outputText;
		}
		this.speed = 100;
		if (speed > 0 ) {
			this.speed = speed;
		}
		nextCharTime = 0;
		if (textField == null) {
			this.textField = Text.createText();
		} else {
			this.textField = textField;
		}
		
		this.addChild(textField);
	}
	
	public function start() {
		this.finished = false;
		this.pause = false;
	}
	
	override public function update(delta:Float) 
	{
		if (!pause && !finished) {
			nextCharTime += delta;
			while (nextCharTime >= speed && outputText.length != 0) {
				nextCharTime -= speed;
				textField.text += outputText.charAt(0);
				outputText = outputText.substring(1, outputText.length);
				finished = outputText.length == 0;
			}
		}
	}	
}