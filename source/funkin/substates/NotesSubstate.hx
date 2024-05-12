package funkin.substates;

import funkin.objects.NotesGroup;

class NotesSubstate extends MusicBeatSubstate
{
    public var SONG:SwagSong;
    public var notesGroup:NotesGroup;
    public var position:Float = 0;

    public function new(song:SwagSong, position:Float)
    {
        super(true, 0x98000000);
        this.position = position;

        SONG = Song.checkSong(song);
        notesGroup = new NotesGroup(SONG, false);
        notesGroup.skipStrumIntro = true;
        notesGroup.init(position - 50);
        Conductor.sync();
        add(notesGroup);

        final txt:FlxFunkText = new FlxFunkText(0, FlxG.height * (Preferences.getPref('downscroll') ? 0.05 : 0.8), "coolswag", FlxPoint.weak(FlxG.width, FlxG.height * 0.3), 25);
        txt.alignment = "center";
        txt._dynamic.update = function (elapsed) {
            txt.text = 'Song Position: ${Math.floor(Conductor.songPosition)}\nCurrent Step: $curStep\nCurrent Beat: $curBeat\nCurrent Section: $curSection\n\nCurrent BPM: ${Conductor.bpm}';
        }
        add(txt);

        camera = CoolUtil.getTopCam();
    }

    override function stepHit(curStep:Int) {
        super.stepHit(curStep);
        Conductor.autoSync();
    }

    override function sectionHit(curSection:Int) {
        super.sectionHit(curSection);
        final curSectionData = SONG.notes[curSection];
        if (curSectionData != null && curSectionData.changeBPM && curSectionData.bpm != Conductor.bpm) {
			Conductor.bpm = curSectionData.bpm;
		}
    }

    var tmr:Float = 0.333;
    override function update(elapsed:Float) {
        super.update(elapsed);
        if (tmr > 0) tmr -= elapsed;
        else {
            if (FlxG.keys.justPressed.ESCAPE || Conductor.songPosition >= Conductor.inst.length) {
                Conductor.songPosition = position;
                Conductor.stop();
                close();
            }
        }

    }
}