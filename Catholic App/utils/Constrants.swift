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
            MenuItemModel(title: "Funciones", emoji: "⚙️", destination: .functions),
            MenuItemModel(title: "Comunidad", emoji: "🤝", destination: .community),
        ]
    }
    
    struct labels {
        static let Tip = "Tips"
        static let Rosary = "Rosario"
        static let Letanies = "Letanias"
        static let HowPray = "Como podré Orar?"
    }
    
}
