import SwiftUI

struct MusicSelectionView: View {
    @Binding var step: AppStep
    var playMusic: (String) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Text("What kind of music are you feeling today?")
                    .font(.system(size: 35, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                HStack(spacing: 15) {
                    Button("Calm Melody") {
                        playMusic("calm_melody")
                        step = .forestScene
                    }
                    .font(.system(size: 30))
                    .frame(minWidth: 200, minHeight: 60)
                    .buttonStyle(.borderedProminent)

                    Button("Fun Tune") {
                        // Empty
                    }
                    .font(.system(size: 30))
                    .frame(minWidth: 200, minHeight: 60)
                    .buttonStyle(.bordered)

                    Button("Energetic Beat") {
                        // Empty
                    }
                    .font(.system(size: 30))
                    .frame(minWidth: 200, minHeight: 60)
                    .buttonStyle(.bordered)
                }
            }
            .padding()

            VStack {
                Spacer()
                Button("Back") {
                    step = .worldSelection
                }
                .font(.system(size: 30))
                .frame(minWidth: 100, minHeight: 44)
                .buttonStyle(.bordered)
                .padding(.bottom, 100)
            }
        }
    }
}

