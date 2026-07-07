
import AVFoundation

// MARK: - Audio Manager
class AudioManager {
    static let shared = AudioManager()
    var player: AVAudioPlayer?

    func playSound(named name: String, from start: TimeInterval = 0) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            if player == nil {
                player = try AVAudioPlayer(contentsOf: url)
            }
            player?.currentTime = start
            player?.play()
        } catch {
            print("Audio error:", error.localizedDescription)
        }
    }

    func pause() {
        player?.pause()
    }

    func stop() {
        player?.stop()
        player = nil
    }
}
