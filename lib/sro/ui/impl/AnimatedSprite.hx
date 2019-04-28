package lib.sro.ui.impl;

import lib.sro.entity.constraint.AbstractEntity;
import lib.sro.layers.DrawableLayer;
import lib.sro.data.StatedAnimationData;
import lib.sro.data.AnimationData;
import lib.sro.ui.constraint.IAnimatedSprite;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class AnimatedSprite extends AbstractEntity implements IAnimatedSprite
{
	private var statedAnimationData:StatedAnimationData;
	private var currentAnimationData:AnimationData;
	private var animationDataQueue:Array<AnimationData>;
	private var bitmap:Bitmap;
	private var animationFinish:Bool;
	private var timeElapsed:Float;
	private var currentAnimationName:String;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null) {
		super(parent);
		animationFinish = false;
		timeElapsed = 0;
		currentAnimationData = statedAnimationData.getDefaultAnimationData();
		this.statedAnimationData = statedAnimationData;
		animationDataQueue = new Array<AnimationData>();
		bitmap = new Bitmap ();
		//bitmap.visible = false;
		addChild (bitmap);
	}
	
	public function change(name:String) {
		if (getCurrentAnimationName() != name) {
			var animationData = statedAnimationData.getAnimationData(name);
			if (animationData != null) {
				currentAnimationData = animationData;
				timeElapsed = 0;
				animationFinish = false;
			}
		}
	}
	
	public function addToQueue(name:String) {
		var animationData = statedAnimationData.getAnimationData(name);
		if (animationData != null) {
			animationDataQueue.push(animationData);
		}
	}
	
	public override function update(delta:Float) {
		super.update(delta);
		
		if (!animationFinish) {
			timeElapsed += delta;
			var loopTime = currentAnimationData.getLoopTime();
			var ratio = timeElapsed / loopTime;
			if (ratio >= 1) {
				if (animationDataQueue.length == 0) {
					if (!currentAnimationData.getLoop()) {
						animationFinish = true;
					}
				} else {
					currentAnimationData = animationDataQueue.pop();
					timeElapsed = 0;
					ratio = 0;
				}
				timeElapsed = Std.int(timeElapsed - ratio * loopTime);
			}
			var indexInFrame = 0;
			if (ratio == 1) { 
				indexInFrame = currentAnimationData.getLength() - 1;
			} else {
				var length = currentAnimationData.getLength();
				var indexInTime = timeElapsed;
				indexInFrame = 0;
				for (i in 0...length) {
					if (currentAnimationData.getSpeedStep(i) > indexInTime) {
						break;
					} else {
						indexInFrame += 1;
					}
				}
			}
			var frame = currentAnimationData.getFrame(indexInFrame);
			bitmap.bitmapData = frame;
		}
	}
	
	public function getBitmapHeigth():Float {
		var toReturn:Float = 0;
		if (bitmap.height == 0) {
			toReturn = currentAnimationData.getDefaultHeight();
		} else {
			toReturn = bitmap.height;
		}
		return toReturn;
	}
	
	public function getBitmapWidth():Float {
		var toReturn:Float = 0;
		if (bitmap.height == 0) {
			toReturn = currentAnimationData.getDefaultHeight();
		} else {
			toReturn = bitmap.width;
		}
		return toReturn;
	}
	
	public function getCurrentAnimationName():String {
		return currentAnimationData.getName();
	}
}