import SwiftUI
import GameplayKit

class TriviaViewModel: ObservableObject {
    @Published var dailyQuestions: [TriviaQuestion] = []
    @Published var score: Int = 0
    @Published var hasCompletedTriviaToday = false

    private let totalDailyQuestions = 5
    private let completedKey = "triviaCompletedDate"

    init() {
        checkIfCompletedToday()
        if !hasCompletedTriviaToday {
            generateDailyTrivia()
        }
    }

    func generateDailyTrivia() {
        let today = Calendar.current.startOfDay(for: Date())
        let seed = today.timeIntervalSince1970

        var generator = SeededGenerator(seed: UInt64(seed))
        dailyQuestions = sampleQuestions.shuffled(using: &generator).prefix(totalDailyQuestions).map { $0 }
        score = 0
    }

    func incrementScore() {
        score += 1
    }

    func markAsCompleted() {
        let today = Calendar.current.startOfDay(for: Date())
        UserDefaults.standard.set(today, forKey: completedKey)
        hasCompletedTriviaToday = true
    }

    private func checkIfCompletedToday() {
        let today = Calendar.current.startOfDay(for: Date())
        if let savedDate = UserDefaults.standard.object(forKey: completedKey) as? Date {
            hasCompletedTriviaToday = Calendar.current.isDate(savedDate, inSameDayAs: today)
        } else {
            hasCompletedTriviaToday = false
        }
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
