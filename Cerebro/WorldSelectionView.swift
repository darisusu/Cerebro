import SwiftUI

struct WorldSelectionView: View {
    @Binding var step: AppStep

    var body: some View {
        VStack(spacing: 30) {
            Text("Which world should we step into today?")
                .font(.system(size: 35, weight: .regular))

            HStack(spacing: 35) {
                Button("Forest") {
                    step = .musicSelection
                }
                .font(.system(size: 30))
                .buttonStyle(.borderedProminent)

                Button("Cave") {
                    // Empty for demo
                }
                .font(.system(size: 30))
                .buttonStyle(.bordered)

                Button("Mountain") {
                    // Empty for demo
                }
                .font(.system(size: 30))
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

