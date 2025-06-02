import SwiftUICore
struct Constants {
    struct Titles {
        static let appName = "Catholic App"
        static let home = "Inicio"
        static let search = "Busqueda"
        static let searching = "Buscando"
        static let menu = "Menu"
        static let profile = "Perfil"
        static let settings = "Configuración"
        static let closeCession = "Cerrar Sesión"
    }

    struct Icons {
        static let menu = "line.horizontal.3"
        static let arrowBackward = "arrow.backward"
        static let home = "house"
        static let gear = "gear"
        static let profile = "person.circle"
        static let tips = "💡"
        static let rosario = "📿"
        static let letanias = "🙏"
        static let howPray = "📖"
    }

    struct Colors {
        static let primary = "PrimaryColor"
    }
    
    struct urls {
        static let checkHealth = "https://bible-api-a2sa.onrender.com/libros/ping"
        static let randomVersicles = "https://bible-api-a2sa.onrender.com/libros/versiculos/aleatorios"
        static let books = "https://bible-api-a2sa.onrender.com/libros"
        static let detailBook = "https://bible-api-a2sa.onrender.com/libros/genesis/capitulos/3"
        static let search = "https://bible-api-a2sa.onrender.com/libros/search"
        static let evangelio = "https://bible-api-a2sa.onrender.com/libros/evangelio"
        static let saints = "https://bible-api-a2sa.onrender.com/libros/santos/hoy/"
    }
    
    struct keys {
        static let list = [
            ("Favoritos", "⭐", "FV"),
            ("Funcionalidades Espirituales", "🙏", "FE"),
            ("Recursos y Formación", "📚", "RF"),
            ("Herramientas de Organización Espiritual", "📅", "HO"),
            ("Conexión y Comunidad", "🌐", "CM"),
            ("Interactivos y Educativos", "🎮", "ED")
        ]
        static let menuItems: [MenuItemModel] = [
            MenuItemModel(title: "Favoritos", emoji: "⭐️", destination: .favorites),
            MenuItemModel(title: "Herramientas", emoji: "🧰", destination: .tools),
            MenuItemModel(title: "Juegos", emoji: "🎮", destination: .games),
            MenuItemModel(title: "Recursos", emoji: "📚", destination: .resources),
            MenuItemModel(title: "Funciones", emoji: "⚙️", destination: .funciones),
            MenuItemModel(title: "Comunidad", emoji: "🤝", destination: .community),
        ]
    }
    
    struct labels {
        static let Tip: LocalizedStringKey = "title_tip"
        static let Rosary = "Rosario"
        static let Letanies = "Letanias"
        static let HowPray = "Como podré Orar?"
    }
    
}


extension Novena {
    static let list = [
        Novena(
            title: "Novena al Sagrado Corazón",
            prayers: [
                "Día 1: Oh Corazón de Jesús, fuente inagotable de misericordia, te adoro y te ofrezco mis oraciones.",
                "Día 2: Corazón de Jesús, lleno de amor y compasión, derrama tus gracias sobre nosotros.",
                "Día 3: Corazón de Jesús, llama de amor viva, enciende en mí un fuego de amor por Ti.",
                "Día 4: Corazón de Jesús, refugio de los pecadores, ten piedad de nosotros.",
                "Día 5: Corazón de Jesús, esperanza de los enfermos, consuela a los que sufren.",
                "Día 6: Corazón de Jesús, paz y reconciliación de los corazones, restaura la unidad en nuestras familias.",
                "Día 7: Corazón de Jesús, fortaleza de los humildes, fortalece mi fe y confianza en Ti.",
                "Día 8: Corazón de Jesús, amigo de los niños y los pequeños, protégelos siempre.",
                "Día 9: Corazón de Jesús, reina y soberano de mi vida, recibe mi corazón y hazlo semejante al Tuyo."
            ]
        ),
        Novena(
            title: "Novena a la Virgen María",
            prayers: [
                "Día 1: Virgen María, Madre llena de gracia, te pido intercedas por mí ante tu Hijo.",
                "Día 2: María, estrella de la mañana, guía mis pasos hacia la luz de Cristo.",
                "Día 3: Madre amorosa, consuelo de los afligidos, escucha mi oración y ayúdame.",
                "Día 4: María, refugio de los pecadores, cubre con tu manto mi vida entera.",
                "Día 5: Virgen Purísima, ejemplo de humildad y fe, ayúdame a seguir tu ejemplo.",
                "Día 6: Madre de misericordia, llena de ternura, abre tu corazón a mis necesidades.",
                "Día 7: Reina del cielo, luz en la oscuridad, acompáñame en mis luchas diarias.",
                "Día 8: Madre del Salvador, intercede por la paz en mi corazón y en el mundo.",
                "Día 9: Virgen bendita, madre y protectora, recibe mis oraciones con amor maternal."
            ]
        )
    ]
}
