import SwiftUI

class TriviaViewModel: ObservableObject {
    @Published var dailyQuestions: [TriviaQuestion] = []
    @Published var score: Int = 0
    
    private var askedQuestions: Set<UUID> = []
    private let totalDailyQuestions = 5
    
    init() {
        generateDailyTrivia()
    }
    
    func generateDailyTrivia() {
        let today = Calendar.current.startOfDay(for: Date())
        let seed = today.timeIntervalSince1970
        
        var generator = SeededGenerator(seed: UInt64(seed))
        dailyQuestions = sampleQuestions.shuffled(using: &generator).prefix(totalDailyQuestions).map { $0 }
        score = 0
        askedQuestions.removeAll()
    }
    
    func incrementScore() {
        score += 1
    }
}
