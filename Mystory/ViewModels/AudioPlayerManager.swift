//
//  AudioPlayerManager.swift
//  Mystory
//
//  Created by Jojo on 14/12/2025.
//

import AVFoundation
import Combine

final class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()

    private var player: AVAudioPlayer?
    private var currentFileName: String?

    // MARK: - Playback
    func togglePlay(fileName: String) {
        // لو نفس الملف
        if currentFileName == fileName {
            if let player = player {
                if player.isPlaying {
                    player.pause()
                } else {
                    player.play()
                }
            }
            return
        }

        // ملف جديد
        stop()
        currentFileName = fileName

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("❌ Audio file not found: \(fileName)")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("❌ Audio error:", error)
        }
    }

    func stop() {
        player?.stop()
        player = nil
        currentFileName = nil
    }
}
