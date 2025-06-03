import SwiftUICore
import SwiftUI
import XCUIAutomation
import GameplayKit

struct TriviaView: View {
    @State private var currentQuestionIndex = 0
    @State private var showAnswer = false
    @State private var selectedOption: String? = nil
    @StateObject var viewModel = TriviaViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {

            Text("Trivia Católica")
                .font(.title)
                .bold()
            
            Text("Puntos: \(viewModel.score)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(viewModel.dailyQuestions[currentQuestionIndex].question)
                .font(.headline)
                .multilineTextAlignment(.center)

            ForEach(viewModel.dailyQuestions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    showAnswer = true
                    if option == viewModel.dailyQuestions[currentQuestionIndex].correctAnswer {
                        viewModel.incrementScore()
                    }
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .disabled(showAnswer)
            }

            if showAnswer {
                Text("Correcta: **\(viewModel.dailyQuestions[currentQuestionIndex].correctAnswer)**")
                    .foregroundColor(.green)
                
                if currentQuestionIndex < viewModel.dailyQuestions.count - 1 {
                    Button("Siguiente") {
                        currentQuestionIndex += 1
                        showAnswer = false
                        selectedOption = nil
                    }
                    .padding(.top)
                } else {
                    VStack {
                        Text("¡Has completado la trivia de hoy!")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top)
                        Button("Salir") {
                            dismiss()
                        }
                        .padding()
                        .bold()
                        .font(.system(.title, design: .rounded))
                        .foregroundStyle(.red)
                        .cornerRadius(25)
                        
                    }

                }
            }
        }
        .padding()
        .onAppear {
            viewModel.generateDailyTrivia()
        }
        .background(Color(.systemBackground))
    }
}

struct SeededGenerator: RandomNumberGenerator {
    private var generator: GKMersenneTwisterRandomSource
    
    init(seed: UInt64) {
        self.generator = GKMersenneTwisterRandomSource(seed: seed)
    }
    
    mutating func next() -> UInt64 {
        return UInt64(bitPattern: Int64(generator.nextInt()))
    }
}

#Preview {
    TriviaView()
        .environment(\.colorScheme, .dark)
}
