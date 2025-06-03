import Foundation

class ToolsViewModel: ObservableObject {
    
    private let toolsService: IToolsService
    
    init(toolsService: IToolsService) {
        self.toolsService = toolsService
    }

    func fetchSaintsOfDay(month: Int, day: Int) async -> [LiturgicalEvent] {
        do {
            return try await toolsService.fetchSaintsOfDay(month: month, day: day)
        } catch {
            print("Error fetching saints of day \(day)/\(month): \(error)")
            return []
        }
    }
    
    func getLiturgicalCycle(for date: Date) -> LiturgicalCycleInfo {
        // 🟣 Implementación simplificada — en producción puede depender de un API o lógica más compleja
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        // Tiempo litúrgico aproximado (simplificado)
        let season: String
        let color: LiturgicalColor

        if (month == 12 && day >= 25) || (month == 1 && day <= 6) {
            season = "Navidad"
            color = .white
        } else if (month == 11 && day >= 27) || (month == 12 && day < 25) {
            season = "Adviento"
            color = .purple
        } else if (month == 2 && day >= 14) || (month == 3 && day <= 28) {
            season = "Cuaresma"
            color = .purple
        } else if (month == 3 && day >= 31) || (month == 4 || month == 5 && day <= 19) {
            season = "Pascua"
            color = .white
        } else {
            season = "Tiempo Ordinario"
            color = .green
        }
        // Año litúrgico (cambia en Adviento)
        let liturgicalYear = (month == 12 && day >= 3) ? year + 1 : year
        let cycle = ["A", "B", "C"][(liturgicalYear % 3)]

        return LiturgicalCycleInfo(liturgicalColor: color, season: season, yearCycle: cycle)
    }
    
    func getKeyLiturgicalCountdownEvents(from date: Date = Date()) -> [CountdownEvent] {
        let calendar = Calendar(identifier: .gregorian)
        let currentYear = calendar.component(.year, from: date)
        var events: [CountdownEvent] = []

        // ✝️ Pascua: primer domingo después de la primera luna llena tras el equinoccio de primavera
        guard let easter = calculateEasterDate(for: currentYear) else { return events }

        // 📅 Otras fechas móviles
        let ashWednesday = calendar.date(byAdding: .day, value: -46, to: easter)!
        let palmSunday = calendar.date(byAdding: .day, value: -7, to: easter)!
        let holyThursday = calendar.date(byAdding: .day, value: -3, to: easter)!
        let goodFriday = calendar.date(byAdding: .day, value: -2, to: easter)!
        let pentecost = calendar.date(byAdding: .day, value: 49, to: easter)!
        let ascension = calendar.date(byAdding: .day, value: 39, to: easter)!

        // 🎄 Navidad (fija)
        let christmas = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25))!

        // 🎁 Agregar eventos si aún no han pasado
        if ashWednesday > date {
            events.append(CountdownEvent(title: "Miércoles de Ceniza", targetDate: ashWednesday))
        }
        if palmSunday > date {
            events.append(CountdownEvent(title: "Domingo de Ramos", targetDate: palmSunday))
        }
        if holyThursday > date {
            events.append(CountdownEvent(title: "Jueves Santo", targetDate: holyThursday))
        }
        if goodFriday > date {
            events.append(CountdownEvent(title: "Viernes Santo", targetDate: goodFriday))
        }
        if easter > date {
            events.append(CountdownEvent(title: "Domingo de Pascua", targetDate: easter))
        }
        if ascension > date {
            events.append(CountdownEvent(title: "Ascensión del Señor", targetDate: ascension))
        }
        if pentecost > date {
            events.append(CountdownEvent(title: "Pentecostés", targetDate: pentecost))
        }
        if christmas > date {
            events.append(CountdownEvent(title: "Navidad", targetDate: christmas))
        }

        return events.sorted { $0.targetDate < $1.targetDate }
    }

    func daysBetween(_ from: Date, _ to: Date) -> Int {
        let diff = Calendar.current.dateComponents([.day], from: from, to: to)
        return diff.day ?? 0
    }
    
    /// Algoritmo de Meeus para calcular la fecha de Pascua (iglesia occidental)
    func calculateEasterDate(for year: Int) -> Date? {
        let a = year % 19
        let b = year / 100
        let c = year % 100
        let d = b / 4
        let e = b % 4
        let f = (b + 8) / 25
        let g = (b - f + 1) / 3
        let h = (19 * a + b - d - g + 15) % 30
        let i = c / 4
        let k = c % 4
        let l = (32 + 2 * e + 2 * i - h - k) % 7
        let m = (a + 11 * h + 22 * l) / 451
        let month = (h + l - 7 * m + 114) / 31
        let day = ((h + l - 7 * m + 114) % 31) + 1

        return Calendar(identifier: .gregorian).date(from: DateComponents(year: year, month: month, day: day))
    }
}
