package lib.sro.core;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;
/**
 * ...
 * @author Sebastien roelandt
 */
class Text
{
	public static function createText(?fontId:String, ?size:Int = 16, ?color:Int = 0xFFFFFF, 
		?align:TextFormatAlign, ?bold:Bool = false) : TextField 
	{
		var textField:TextField = new TextField();
		
		if (align == null) {
			align = TextFormatAlign.LEFT;
		}
		var textFormat = textField.defaultTextFormat;
		if (fontId != null) {
			var font = Assets.getFont("fonts/" + fontId);
			textFormat.font = font.fontName;
		}
		textFormat.size = size;
		textFormat.color = color;
		textFormat.align = align;
		textFormat.bold = bold;
		
		textField.defaultTextFormat = textFormat;
		textField.setTextFormat(textFormat);
		if (fontId != null) {
			textField.embedFonts = true;
		}
		textField.mouseEnabled = false;
		textField.selectable = false;
		textField.wordWrap = true;
		textField.gridFitType = openfl.text.GridFitType.PIXEL;
		
		textField.x = 10;
		textField.y = 10;
		textField.width = 500;
		
		return textField;
	}
	
}