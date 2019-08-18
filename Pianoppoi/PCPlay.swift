//
//  PCPlay.swift
//  Pianoppoi
//
//  Created by paraches on 2019/08/18.
//  Copyright © 2019年 paraches lifestyle lab. All rights reserved.
//

import Foundation
import AudioToolbox

enum Pitch: UInt8 {
    case C4 = 60, Cs4, D4, Ds4, E4, F4, Fs4, G4, Gs4, A4, As4, B4,
        C5, Cs5, D5, Ds5, E5, F5, Fs5, G5, Gs5, A5, As5, B5
}

class PCPlay {
    var musicPlayer : MusicPlayer? = nil

    init() {
        let result = NewMusicPlayer(&musicPlayer)
        if result != noErr {
            print("Error: NewMusicPlayer")
        }
        else {
            //  dummy to wake up MusicPlayer
            //  this make small/short noise...
            if let sequence = createSequence(pitch: .C4) {
                MusicPlayerSetSequence(musicPlayer!, sequence)
                MusicPlayerStart(musicPlayer!)
                MusicPlayerStop(musicPlayer!)
            }
        }
    }
    
    func play(pitch: Pitch) {
        if let sequence = createSequence(pitch: pitch) {
            MusicPlayerStop(musicPlayer!)
            MusicPlayerSetSequence(musicPlayer!, sequence)
            MusicPlayerStart(musicPlayer!)
        }
        else {
            print("Fail to create sequence")
        }
    }
    
    func play(number: Int) {
        if let pitch = Pitch(rawValue: UInt8(number)) {
            play(pitch: pitch)
        }
    }
    
    private func createSequence(pitch: Pitch) -> MusicSequence? {
        var sequence : MusicSequence? = nil
        NewMusicSequence(&sequence)
        
        var track : MusicTrack? = nil
        MusicSequenceNewTrack(sequence!, &track)
        
        let time = MusicTimeStamp(0.0)
        var note = MIDINoteMessage(channel: 0,
                                   note: pitch.rawValue,
                                   velocity: 64,
                                   releaseVelocity: 0,
                                   duration: 1/15 )
        MusicTrackNewMIDINoteEvent(track!, time, &note)
        
        return sequence
    }

}
