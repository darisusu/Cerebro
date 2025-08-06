import SwiftUI
import AVFoundation

enum AppStep {
    case welcome, worldSelection, musicSelection, forestScene, exit
}

struct MainAppView: View {
    @State private var step: AppStep = .welcome
    @State private var musicPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            switch step {
            case .welcome:
                WelcomeView(step: $step)
            case .worldSelection:
                WorldSelectionView(step: $step)
            case .musicSelection:
                MusicSelectionView(step: $step, playMusic: playMusic)
            case .forestScene:
                ForestSceneView()
            case .exit:
                ExitView()
            }
        }
    }

    func playMusic(named name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer?.play()
            } catch {
                print("Failed to play music: \(error)")
            }
        }
    }
}

