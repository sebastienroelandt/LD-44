package lib.sro.data;

import openfl.display.BitmapData;

/**
 * ...
 * @author Sebastien roelandt
 */
class StatedAnimationData
{
	private var name:String;
	private var animationDatas: Map<String, AnimationData>;

	public function new(name:String) 
	{
		this.animationDatas = new Map();
		this.name = name;
	}
	
	public function addLinearFrames(name:String, frames:Array<BitmapData>, ?speed:Int = 1):Void {
		getAnimationData(name).addLinearFrames(frames, speed);
	}
	
	public function addVariousFrames(name:String, frames:Array<BitmapData>, speeds:Array<Int>):Void {
		getAnimationData(name).addVariousFrames(frames, speeds);
	}
	
	public function setLoop(name:String, loop:Bool):Void {
		var animationData = animationDatas.get(name);
		if (animationData != null) {
			animationData.setLoop(loop);
		}
	}
	
	public function getAnimationData(name:String):AnimationData {
		var animationData = animationDatas.get(name);
		if (animationData == null) {
			animationData = new AnimationData(name, true);
			animationDatas.set(name, animationData);
		}
		return animationData;
	}
	
	public function getDefaultAnimationData():AnimationData {
		var animationData = null;
		var iterator = animationDatas.iterator();
		if (iterator.hasNext()) {
			animationData = iterator.next();
		}
		return animationData;
	}
	
	public function getAnimationTime():Float {
		return getDefaultAnimationData().getLoopTime(); 
	}
}