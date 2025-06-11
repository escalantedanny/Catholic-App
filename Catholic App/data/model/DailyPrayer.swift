import Foundation
import SwiftUI
import MapKit

struct DailyPrayer: Identifiable, Codable, Hashable {
    let id: UUID
    let dayTitle: String
    let prayer: String
}

struct Novena: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let prayers: [DailyPrayer]
    let threePadreNuestros: String?
    let oracionesFinales: String?
    
    static func getNovenas() -> [Novena] {
        return Novena.list
    }
}

struct LiturgicalCycleInfo {
    let liturgicalColor: LiturgicalColor
    let season: String // "Adviento", "Navidad", etc.
    let yearCycle: String // "A", "B", o "C"
}

enum LiturgicalColor: String {
    case green = "Verde"
    case red = "Rojo"
    case purple = "Morado"
    case white = "Blanco"

    var colorValue: Color {
        switch self {
        case .green: return .green
        case .red: return .red
        case .purple: return .purple
        case .white: return .white
        }
    }
}

struct CountdownEvent: Identifiable {
    let id = UUID()
    let title: String
    let targetDate: Date
}

extension Novena {
    
    static let list = [
        Novena(
            id: UUID(),
            title: "Sagrado Corazón de Jesús",
            prayers: [
                DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Oh Corazón de Jesús, fuente inagotable de misericordia, te adoro y te ofrezco mis oraciones."),
                DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Corazón de Jesús, lleno de amor y compasión, derrama tus gracias sobre nosotros."),
                DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Corazón de Jesús, llama de amor viva, enciende en mí un fuego de amor por Ti"),
                DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "Corazón de Jesús, refugio de los pecadores, ten piedad de nosotros."),
                DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "Corazón de Jesús, esperanza de los enfermos, consuela a los que sufren."),
                DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "Corazón de Jesús, paz y reconciliación de los corazones, restaura la unidad en nuestras familias."),
                DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "Corazón de Jesús, fortaleza de los humildes, fortalece mi fe y confianza en Ti."),
                DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "Corazón de Jesús, amigo de los niños y los pequeños, protégelos siempre."),
                DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "Corazón de Jesús, reina y soberano de mi vida, recibe mi corazón y hazlo semejante al Tuyo.")
            ],
            threePadreNuestros: "Tres Padrenuestros y Avemarías.",
            oracionesFinales: """
            ORACIONES FINALES

            Al Padre eterno.
            ¡Oh Padre Eterno! Por medio del Corazón de Jesús, mi vida, mi verdad y mi camino, llego a Vuestra Majestad; por medio de este adorable Corazón, os adoro por todos los hombres que no os adoran; os amo por todos los que no os aman; os conozco por todos los que, voluntariamente ciegos, no quieren conoceros...

            *(Hacer aquí la petición que se desea obtener con esta novena)*

            *Oración final.*  
            ¡Oh Corazón divinísimo de Jesús, dignísimo de la adoración de los hombres y de los ángeles!...  
            Amén.
            """
        ),
        Novena(
            id: UUID(),
            title: "Santa Rita de Casia",
            prayers: [
                DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Santa Rita, mujer de fe inquebrantable, intercede por nosotros para que también confiemos siempre en Dios."),
                DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Santa Rita, ejemplo de paciencia, ayúdanos a aceptar con amor las pruebas de la vida."),
                DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Santa Rita, fiel esposa y madre, enséñanos a amar y servir a nuestras familias con humildad."),
                DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "Santa Rita, mujer de paz, intercede por la reconciliación en nuestros hogares y comunidades."),
                DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "Santa Rita, amante del crucificado, danos fuerza para cargar nuestra cruz con esperanza."),
                DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "Santa Rita, flor del perdón, enséñanos a perdonar sinceramente como tú lo hiciste."),
                DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "Santa Rita, humilde sierva de Dios, ayúdanos a servir a los demás con alegría."),
                DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "Santa Rita, portadora de la espina, intercede por nuestras causas imposibles."),
                DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "Santa Rita, patrona de los casos desesperados, ruega por nosotros y nuestras necesidades.")
            ],
            threePadreNuestros: "Rezar tres Padrenuestros, Avemarías y Glorias.",
            oracionesFinales: """
            ORACIÓN FINAL

            Oh gloriosa Santa Rita, abogada de los imposibles, en ti confío plenamente. Alcánzanos del Señor lo que con fe te pedimos. Intercede por nosotros ante Jesús crucificado, como tú supiste hacerlo en vida. Amén.
            """
        ),
        Novena(
            id: UUID(),
            title: "San Miguel Arcángel",
            prayers: [
                DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "San Miguel Arcángel, defensor en la batalla, protégeme del mal que me acecha."),
                DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Príncipe de la milicia celestial, fortaléceme en las pruebas y tentaciones."),
                DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "San Miguel, luz contra la oscuridad, guía mis pasos hacia el bien."),
                DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "San Miguel, protector de la Iglesia, defiéndela de todo ataque y división."),
                DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "San Miguel, mensajero de justicia, ayuda a sanar mi corazón herido."),
                DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "San Miguel, ángel del juicio, inspírame a vivir con rectitud y verdad."),
                DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "San Miguel, compañero de los justos, acompáñame en cada paso del camino."),
                DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "San Miguel, vencedor del dragón, líbranos del poder del maligno."),
                DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "San Miguel, custodio de las almas, acompáñanos en la hora de nuestra muerte.")
            ],
            threePadreNuestros: "Rezar tres Padrenuestros, Avemarías y el Gloria en honor a San Miguel.",
            oracionesFinales: """
            ORACIÓN FINAL

            San Miguel Arcángel, defiéndenos en la lucha, sé nuestro amparo contra la perversidad y las asechanzas del demonio. Que Dios manifieste sobre él su poder, es nuestra humilde súplica. Y tú, Príncipe de la milicia celestial, con el poder que Dios te ha conferido, arroja al infierno a Satanás y a los demás espíritus malignos. Amén.
            """
        ),
        Novena(
            id: UUID(),
            title: "Divina Misericordia",
            prayers: [
                DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Hoy tráeme a toda la humanidad, especialmente a los pecadores, y sumérgelos en el mar de Mi misericordia."),
                DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Hoy tráeme a las almas de los sacerdotes y religiosos, y sumérgelos en Mi misericordia."),
                DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Hoy tráeme a todas las almas devotas y fieles, y sumérgelas en el océano de Mi misericordia."),
                DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "Hoy tráeme a los que no creen en Dios y a los que aún no Me conocen."),
                DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "Hoy tráeme a las almas de los hermanos separados y sumérgelas en Mi misericordia."),
                DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "Hoy tráeme a las almas mansas y humildes, y a las de los niños pequeños."),
                DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "Hoy tráeme a las almas que veneran y glorifican Mi misericordia de modo especial."),
                DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "Hoy tráeme a las almas del purgatorio y sumérgelas en el abismo de Mi misericordia."),
                DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "Hoy tráeme a las almas tibias, y sumérgelas en el abismo de Mi misericordia.")
            ],
            threePadreNuestros: "",
            oracionesFinales: """
            ORACIÓN FINAL

            Oh Sangre y Agua que brotaste del Corazón de Jesús como fuente de misericordia para nosotros, en Ti confío.  
            Jesús, en Ti confío.  
            Jesús, en Ti confío.  
            Jesús, en Ti confío.

            (Rezar la Coronilla de la Divina Misericordia)

            Oh Dios, cuya misericordia es infinita y cuyos tesoros de compasión no tienen límites, míranos con tu favor y aumenta tu misericordia en nosotros, para que en momentos difíciles no desesperemos ni nos desalentemos, sino que con gran confianza nos sometamos a tu santa voluntad, que es amor y misericordia mismos. Amén.
            """
        ),
        Novena(
            id: UUID(),
            title: "Novena al Espíritu Santo",
            prayers: [
                DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Espíritu Santo, Señor de luz, ilumina nuestro corazón. Ven y danos tu gracia para comprender la voluntad del Padre."),
                DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Espíritu Santo, Espíritu de Sabiduría, enséñanos a amar lo que es verdadero y eterno."),
                DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Espíritu Santo, Espíritu de Entendimiento, abre nuestras mentes para conocer la verdad divina."),
                DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "Espíritu Santo, Espíritu de Consejo, guía nuestros pasos en los momentos de dificultad."),
                DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "Espíritu Santo, Espíritu de Fortaleza, danos fuerza para cumplir con valentía la voluntad de Dios."),
                DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "Espíritu Santo, Espíritu de Ciencia, muéstranos el camino que lleva a la vida eterna."),
                DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "Espíritu Santo, Espíritu de Piedad, llena nuestro corazón de amor filial hacia Dios."),
                DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "Espíritu Santo, Espíritu de Temor de Dios, haz que no nos alejemos nunca de su amor."),
                DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "Espíritu Santo, dona tus siete dones, fortalece nuestra fe y enciende en nosotros el fuego de tu amor.")
            ],
            threePadreNuestros: """
            Rezar tres veces:
            
            Padre Nuestro, Ave María y Gloria.
            """,
            oracionesFinales: """
            ORACIÓN FINAL

            Ven, Espíritu Santo, llena los corazones de tus fieles y enciende en ellos el fuego de tu amor.
            Envía, Señor, tu Espíritu y todo será creado.
            Y renovarás la faz de la tierra.

            Oremos:
            Oh Dios, que has instruido los corazones de tus fieles con la luz del Espíritu Santo,
            concédenos que sintamos rectamente con el mismo Espíritu y gocemos siempre de su divino consuelo.
            Por Cristo nuestro Señor. Amén.
            """
        )
    ]
}

