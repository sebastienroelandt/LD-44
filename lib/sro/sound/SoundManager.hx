package lib.sro.sound;

import openfl.events.Event;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.events.Event;

/**
 * ...
 * @author Sebastien roelandt
 */
class SoundManager
{
	private static var ME	: SoundManager;
	
	private var playingList		: Array<SoundChannel>;
	public var isActive 		: Bool;
	
	private function new() {
		playingList = new Array();
		isActive = true;
	}

	public static function getInstance():SoundManager {
		if (ME == null) {
			ME = new SoundManager();
		}
		return ME;
	}
	
	public function play(sound:Sound, ?soundVolume = 1.0) {
		if (soundVolume >= 0 && soundVolume <= 1 && sound != null && isActive) {
			var soundChannel:SoundChannel = sound.play(0, 1);
			soundChannel.soundTransform = new SoundTransform(soundVolume);
		}
	}
	
	private function onSoundComplete(event:Event) {
		var soundChannel:SoundChannel = event.target;
		soundChannel.stop();
		soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		playingList.remove(soundChannel);
	}
	
	public function changeVolume(value:Float) {
		if (value >= 0 && value <= 1) {
			for (soundChannel in playingList) {
				soundChannel.soundTransform = new SoundTransform(value);
			}
		}
	}
	
	public function stop() {
		isActive = false;
	}
	
	public function start() {
		isActive = true;
	}
}