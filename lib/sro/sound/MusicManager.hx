package lib.sro.sound;

import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.events.Event;
import openfl.media.SoundTransform;

/**
 * ...
 * @author Sebastien roelandt
 */
class MusicManager
{
	private static var ME			: MusicManager;
	private static var maxVolume	= 100.0;
	
	private var currentSound		: Sound;
	private var musicPlayer			: SoundChannel;
	private var musicVolume			: Float;
	private var isMuted				: Bool;
	private var loop				: Bool;
	
	private function new() {
		musicVolume = 100;
		isMuted = false;
		loop = true;
		currentSound = null;
	}

	public static function getInstance():MusicManager {
		if (ME == null) {
			ME = new MusicManager();
		}
		return ME;
	}
	
	public function start(sound:Sound, ?reset = false) {
		if (sound != null && (reset || sound != currentSound)) {
			stop();
			currentSound = sound;
			musicPlayer = currentSound.play(0, 1);
			musicPlayer.soundTransform = new SoundTransform(getRealVolume());
			musicPlayer.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
	}
	
	public function stop() {
		if (currentSound != null && musicPlayer!= null) {
			musicPlayer.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			musicPlayer.stop();
			currentSound = null;
		}
	}
	
	private function onSoundComplete(event:Event) {
		musicPlayer.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		if (loop) {
			start (currentSound, true);
		}
	}
	
	private function getRealVolume():Float {
		return musicVolume / maxVolume;
	}
	
	public function changeVolume(value:Float) {
		if (value >= 0 && value <= maxVolume) {
			musicVolume = value;
			if (musicPlayer != null) {
				musicPlayer.soundTransform = new SoundTransform(getRealVolume());
			}
		}
	}
	
	public function getVolume():Float {
		return musicVolume;
	}
}
