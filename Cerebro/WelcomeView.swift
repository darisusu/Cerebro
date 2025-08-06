import SwiftUI

struct WelcomeView: View {
    @Binding var step: AppStep

    var body: some View {
        VStack(spacing: 30) {
            Text("Good morning!")
                .font(.system(size: 42, weight: .regular)) // Large, not bold

            Text("Would you like to start your memory exercise?")
                .font(.system(size: 35, weight: .regular)) // Medium-large
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack(spacing: 40) {
                Button("Yes") {
                    step = .worldSelection
                }
                .buttonStyle(.borderedProminent)
                .font(.system(size: 30)) // Optional: Slightly larger button text

                Button("No") {
                    step = .exit
                }
                .buttonStyle(.bordered)
                .font(.system(size: 30))
            }
        }
        .padding()
        
    }
}

