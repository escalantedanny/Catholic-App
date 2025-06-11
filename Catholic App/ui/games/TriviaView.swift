import SwiftUI
import SwiftUI
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
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top)
            
            if viewModel.hasCompletedTriviaToday {
                Text("Ya has completado la trivia de hoy 🙌")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Vuelve mañana para más preguntas.")
                    .foregroundColor(.gray)

                Button("Salir") {
                    dismiss()
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
                
            } else {
                Text("Puntos: \(viewModel.score)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                questionCard

                Spacer()

                if showAnswer {
                    answerSection
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.generateDailyTrivia()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }

    private var questionCard: some View {
        let question = viewModel.dailyQuestions[currentQuestionIndex]

        return VStack(spacing: 16) {
            Text(question.question)
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            ForEach(question.options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    showAnswer = true
                    if option == question.correctAnswer {
                        viewModel.incrementScore()
                    }
                }) {
                    HStack {
                        Text(option)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .background(optionBackground(option: option))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                }
                .disabled(showAnswer)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 4))
    }

    private func optionBackground(option: String) -> Color {
        if showAnswer {
            if option == viewModel.dailyQuestions[currentQuestionIndex].correctAnswer {
                return Color.green.opacity(0.3)
            } else if option == selectedOption {
                return Color.red.opacity(0.3)
            }
        }
        return Color.blue.opacity(0.1)
    }

    private var answerSection: some View {
        VStack(spacing: 16) {
            Text("Respuesta correcta:")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(viewModel.dailyQuestions[currentQuestionIndex].correctAnswer)
                .font(.headline)
                .foregroundColor(.green)

            if currentQuestionIndex < viewModel.dailyQuestions.count - 1 {
                Button("Siguiente pregunta") {
                    currentQuestionIndex += 1
                    showAnswer = false
                    selectedOption = nil
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            } else {
                VStack(spacing: 10) {
                    Text("🎉 ¡Has completado la trivia de hoy!")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)

                    Button("Salir") {
                        viewModel.markAsCompleted()
                        dismiss()
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: showAnswer)
    }
}

#Preview {
    TriviaView()
        .environment(\.colorScheme, .dark)
}
