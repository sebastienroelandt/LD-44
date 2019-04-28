package lib.sro.entity.impl;

import lib.sro.data.StatedAnimationData;
import lib.sro.entity.constraint.AbstractEntity;
import lib.sro.entity.constraint.IBasicEntity;
import lib.sro.ui.impl.AnimatedSprite;
import lib.sro.ui.impl.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicEntity extends AnimatedSprite implements IBasicEntity
{
	//Real position
	private var xx 				: Float;
	private var yy 				: Float;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI=null) 
	{
		super(statedAnimationData, parent);
		
		xx = 0;
		yy = 0;
	}
	
	override public function entityUpdate(delta:Float) 
	{
		this.x = xx;
		this.y = yy;
		
		super.entityUpdate(delta);
	}
	
	public function setHeight(height : Float) {
		this.height = height;
	}

	public function getHeight() : Float {
		return statedAnimationData.getDefaultAnimationData().getFrame(0).height;
	}

	public function setWidth(width : Float) {
		this.width = width;
	}

	public function getWidth() : Float {
		return statedAnimationData.getDefaultAnimationData().getFrame(0).width;
	}

	public function setXx(xx : Float) {
		this.xx = xx;
	}

	public function getXx() : Float {
		return this.xx;
	}

	public function setYy(yy : Float) {
		this.yy = yy;
	}

	public function getYy() : Float {
		return this.yy;
	}

}