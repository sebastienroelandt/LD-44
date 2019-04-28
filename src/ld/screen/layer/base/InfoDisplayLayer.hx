package ld.screen.layer.base;

import ld.screen.layer.InstructionsLayer.Message;
import ld.ui.AdjustableBackground;
import lib.sro.core.Bezier;
import lib.sro.layers.DrawableLayer;
import openfl.text.TextField;
import lib.sro.core.Text;
import lib.sro.input.Keys;
import openfl.ui.Keyboard;
import openfl.Lib;
import ld.event.IInfoDisplayClosedListener;

/**
 * ...
 * @author Roelandt Sebastien
 */
class InfoDisplayLayer extends DrawableLayer
{
	private var queue : Array<String>;
	
	private var isClosing = false;
	private var bezier : Bezier;
	private var beginTime :	Float;
	private var time = 600;
	
	//Main message
	private var info : Message;
	private var close : Message;
	
	private var listener : IInfoDisplayClosedListener;

	public function new(backgroundId : String, height: Int, width: Int, time: Int) 
	{
		super();
		this.time = time;
		
		queue = new Array<String>();
		
		var background = new AdjustableBackground(backgroundId, height, width);
		this.addChild(background);
		
		info = createMessage();
		info.defaultMessage = Text.createText("Minecraftia.ttf", 24);
		info.defaultMessage.x = 30;
		info.defaultMessage.y = 30;
		info.defaultMessage.height = this.height - 30 - 100;
		info.defaultMessage.width = this.width - 30;
		this.addChild(info.defaultMessage);
		createShadows(info);
		
		close = createMessage();
		close.defaultMessage = Text.createText("Minecraftia.ttf", 24, 0x7f8bc6);
		close.defaultMessage.x = 30;
		close.defaultMessage.y = this.height - 55;
		close.defaultMessage.height = 100;
		close.defaultMessage.width = this.width - 30;
		close.defaultMessage.text = "[ENTER to continue]";
		this.addChild(close.defaultMessage);
		createShadows(close, 0.05);
		
		this.visible = false;
		this.bezier = new Bezier(BezierType.FastOut);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (Keys.isClick(Keyboard.ENTER) && close.defaultMessage.visible && this.visible) {
			if (queue.length > 0) {
				displayNextMessage();
			} else {
				this.isClosing = true;
				this.beginTime = Lib.getTimer();
			}
			
		} else if (isClosing) {
			var currentTime = Lib.getTimer();
			
			var bezierValue = bezier.getValue((currentTime - beginTime)/time);
			if (bezierValue == - 1.00) {
				// End
				this.alpha = 1;
				this.visible = false;
				this.isClosing = false;
				fireClosedEvent();
			} else {
				this.alpha = 1 - bezierValue;
			}
		}
	}
	
	public function displayMessage(message: String) {
		queue.push(message);
		if (!this.visible) {
			displayNextMessage();
		}
	}
	
	private function displayNextMessage() {
		queue.reverse();
		var message = queue.pop();
		queue.reverse();
		
		info.defaultMessage.text = message;
		info.shadowLeft.text = message;
		info.shadowRight.text = message;
		info.shadowTop.text = message;
		info.shadowBottom.text = message;
		
		this.visible = true;
	}
	
	private function createMessage() : Message {
		return {
				defaultMessage : null,
				shadowLeft : null,
				shadowRight : null,
				shadowTop : null,
				shadowBottom : null
		}
	}
	
	private function createShadows(message: Message, ?opacity = 0.13) {
		message.shadowLeft = createShadow(message.defaultMessage, -3, 0, opacity);
		message.shadowRight = createShadow(message.defaultMessage, 3, 0, opacity);
		message.shadowTop = createShadow(message.defaultMessage, 0, -3, opacity);
		message.shadowBottom = createShadow(message.defaultMessage, 0, 3, opacity);
	}
	
	private function createShadow(src:TextField, deltaX:Float, deltaY:Float, opacity:Float) :TextField {
		var shadow = new TextField();
		shadow = Text.createText("Minecraftia.ttf", 24);
		shadow.text = src.text;
		shadow.x = src.x + deltaX;
		shadow.y = src.y + deltaY;
		shadow.height = this.height - 30 - 100;
		shadow.width = this.width - 30;
		shadow.alpha = opacity;		
		this.addChild(shadow);
		return shadow;
	}

	public function setInfoDisplayClosedListener(listener: IInfoDisplayClosedListener) {
		this.listener = listener;
	}
	
	public function fireClosedEvent() {
		if (listener != null) {
			listener.onInfoClosedEvent(getType());
		}
	}
	
	public function getType(): String {
		return "";
	}
	
}