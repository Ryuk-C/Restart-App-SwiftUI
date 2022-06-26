//
//  AudioPlayer.swift
//  Restart
//
//  Created by Cuma Haznedar on 26.06.2022.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {

        do {

            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()

        } catch {
            print("Could'nt play the sound file.")
        }

    }
}
