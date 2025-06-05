import Foundation
struct TriviaQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

let sampleQuestions: [TriviaQuestion] = [
    TriviaQuestion(
        question: "¿Cuántos libros tiene la Biblia Católica?",
        options: ["66", "72", "73", "70"],
        correctAnswer: "73"
    ),
    TriviaQuestion(
        question: "¿Qué santo es conocido como el 'Pobrecillo de Asís'?",
        options: ["San Benito", "San Francisco", "San Pablo", "San Juan Bosco"],
        correctAnswer: "San Francisco"
    ),
    TriviaQuestion(
        question: "¿Quién escribió la mayoría de las cartas del Nuevo Testamento?",
        options: ["San Pedro", "San Pablo", "San Juan", "Santiago"],
        correctAnswer: "San Pablo"
    ),
    TriviaQuestion(
        question: "¿Cuál fue el primer milagro de Jesús según el Evangelio?",
        options: ["Sanar a un ciego", "Multiplicar los panes", "Convertir agua en vino", "Resucitar a Lázaro"],
        correctAnswer: "Convertir agua en vino"
    ),
    TriviaQuestion(
        question: "¿Dónde nació Jesús?",
        options: ["Nazaret", "Jerusalén", "Belén", "Egipto"],
        correctAnswer: "Belén"
    ),
    TriviaQuestion(
        question: "¿Quién recibió las tablas de la ley en el monte Sinaí?",
        options: ["Abraham", "Isaac", "Moisés", "Elías"],
        correctAnswer: "Moisés"
    ),
    TriviaQuestion(
        question: "¿Qué santa es conocida por sus visiones del Infierno y el Purgatorio?",
        options: ["Santa Faustina", "Santa Teresa de Ávila", "Santa Catalina de Siena", "Santa Margarita"],
        correctAnswer: "Santa Faustina"
    ),
    TriviaQuestion(
        question: "¿Qué Papa convocó el Concilio Vaticano II?",
        options: ["Pío XII", "Pablo VI", "Juan XXIII", "Juan Pablo II"],
        correctAnswer: "Juan XXIII"
    ),
    TriviaQuestion(
        question: "¿Qué día celebramos la Inmaculada Concepción?",
        options: ["25 de marzo", "15 de agosto", "8 de diciembre", "1 de noviembre"],
        correctAnswer: "8 de diciembre"
    ),
    TriviaQuestion(
        question: "¿Qué color litúrgico se usa durante el Adviento?",
        options: ["Verde", "Rojo", "Morado", "Blanco"],
        correctAnswer: "Morado"
    ),
    TriviaQuestion(
        question: "¿Qué representa la ceniza que se impone el Miércoles de Ceniza?",
        options: ["Luto", "Sacrificio", "Conversión y penitencia", "El Espíritu Santo"],
        correctAnswer: "Conversión y penitencia"
    ),
    TriviaQuestion(
        question: "¿Quién traicionó a Jesús por 30 monedas de plata?",
        options: ["Pedro", "Juan", "Judas Iscariote", "Tomás"],
        correctAnswer: "Judas Iscariote"
    ),
    TriviaQuestion(
        question: "¿Cuál es el primer libro del Antiguo Testamento?",
        options: ["Éxodo", "Salmos", "Génesis", "Levítico"],
        correctAnswer: "Génesis"
    ),
    TriviaQuestion(
            question: "¿Qué arcángel anunció a María que sería madre de Jesús?",
            options: ["Miguel", "Gabriel", "Rafael", "Uriel"],
            correctAnswer: "Gabriel"
        ),
    TriviaQuestion(
        question: "¿Qué sacramento borra el pecado original?",
        options: ["Eucaristía", "Bautismo", "Confesión", "Confirmación"],
        correctAnswer: "Bautismo"
    ),
    TriviaQuestion(
        question: "¿Qué día celebramos la Resurrección de Jesús?",
        options: ["Navidad", "Pentecostés", "Domingo de Pascua", "Ascensión"],
        correctAnswer: "Domingo de Pascua"
    ),
    TriviaQuestion(
        question: "¿Cuántos mandamientos entregó Dios a Moisés?",
        options: ["5", "7", "10", "12"],
        correctAnswer: "10"
    ),
    TriviaQuestion(
        question: "¿Cuál es el mandamiento más importante según Jesús?",
        options: ["No matarás", "Amarás a Dios sobre todas las cosas", "Guardarás los domingos", "No mentirás"],
        correctAnswer: "Amarás a Dios sobre todas las cosas"
    ),
    TriviaQuestion(
        question: "¿Cuántos evangelios hay en el Nuevo Testamento?",
        options: ["3", "4", "5", "2"],
        correctAnswer: "4"
    ),
    TriviaQuestion(
        question: "¿Cuál es el nombre del padre terrenal de Jesús?",
        options: ["José", "Juan", "Zacarías", "David"],
        correctAnswer: "José"
    ),
    TriviaQuestion(
        question: "¿Qué es el Rosario?",
        options: ["Un libro de oraciones", "Un canto", "Una meditación sobre la vida de Cristo y María", "Un tipo de misa"],
        correctAnswer: "Una meditación sobre la vida de Cristo y María"
    ),
    TriviaQuestion(
        question: "¿Qué fiesta celebra el nacimiento de la Virgen María?",
        options: ["8 de septiembre", "25 de diciembre", "15 de agosto", "8 de diciembre"],
        correctAnswer: "8 de septiembre"
    ),
    TriviaQuestion(
        question: "¿Qué símbolo representa al Espíritu Santo?",
        options: ["Una paloma", "Una cruz", "Un cordero", "Un pez"],
        correctAnswer: "Una paloma"
    ),
    TriviaQuestion(
        question: "¿Qué sacramento se recibe solo una vez en la vida?",
        options: ["Eucaristía", "Matrimonio", "Bautismo", "Reconciliación"],
        correctAnswer: "Bautismo"
    ),
    TriviaQuestion(
        question: "¿Qué significa la palabra 'Amén'?",
        options: ["Gracias", "Así sea", "Aleluya", "Bendito"],
        correctAnswer: "Así sea"
    ),
    TriviaQuestion(
        question: "¿Qué celebramos en Pentecostés?",
        options: ["La Ascensión", "La venida del Espíritu Santo", "El nacimiento de Jesús", "La resurrección"],
        correctAnswer: "La venida del Espíritu Santo"
    ),
    TriviaQuestion(
        question: "¿Cuál es el salmo más conocido?",
        options: ["Salmo 1", "Salmo 23", "Salmo 91", "Salmo 150"],
        correctAnswer: "Salmo 23"
    ),
    TriviaQuestion(
        question: "¿Qué significa 'Iglesia'?",
        options: ["Templo", "Comunidad de creyentes", "Sacerdocio", "Religión"],
        correctAnswer: "Comunidad de creyentes"
    ),
    TriviaQuestion(
        question: "¿Qué apóstol negó a Jesús tres veces?",
        options: ["Juan", "Santiago", "Pedro", "Andrés"],
        correctAnswer: "Pedro"
    ),
    TriviaQuestion(
        question: "¿Dónde fue crucificado Jesús?",
        options: ["Belén", "Nazaret", "Gólgota", "Jericó"],
        correctAnswer: "Gólgota"
    ),
    TriviaQuestion(
        question: "¿Qué representa el pan en la Eucaristía?",
        options: ["El cuerpo de Cristo", "El amor de Dios", "El perdón", "La comunidad"],
        correctAnswer: "El cuerpo de Cristo"
    ),
    TriviaQuestion(
        question: "¿Quién fue el primer Papa de la Iglesia Católica?",
        options: ["San Juan", "San Pablo", "San Pedro", "San Esteban"],
        correctAnswer: "San Pedro"
    ),
    TriviaQuestion(
        question: "¿Qué día celebramos la Fiesta de Todos los Santos?",
        options: ["2 de noviembre", "25 de diciembre", "15 de agosto", "1 de noviembre"],
        correctAnswer: "1 de noviembre"
    ),
    TriviaQuestion(
        question: "¿Qué significa la palabra 'Evangelio'?",
        options: ["Verdad", "Testimonio", "Buena noticia", "Mensaje de Dios"],
        correctAnswer: "Buena noticia"
    ),
    TriviaQuestion(
        question: "¿Qué virtud teologal nos lleva a confiar en las promesas de Dios?",
        options: ["Fe", "Esperanza", "Caridad", "Paciencia"],
        correctAnswer: "Esperanza"
    ),
    TriviaQuestion(
        question: "¿Qué apóstol fue llamado el 'discípulo amado'?",
        options: ["Pedro", "Tomás", "Juan", "Felipe"],
        correctAnswer: "Juan"
    ),
    TriviaQuestion(
        question: "¿Qué significa el color rojo en la liturgia?",
        options: ["Martirio o Espíritu Santo", "Pecado", "Paz", "Alegría"],
        correctAnswer: "Martirio o Espíritu Santo"
    ),
    TriviaQuestion(
        question: "¿Cuál es el mandamiento más importante según Jesús?",
        options: ["No matarás", "Amarás a Dios sobre todas las cosas", "No robarás", "Santificarás las fiestas"],
        correctAnswer: "Amarás a Dios sobre todas las cosas"
    ),
    TriviaQuestion(
        question: "¿Quién fue el primer Papa de la Iglesia Católica?",
        options: ["San Pablo", "San Juan", "San Pedro", "San Esteban"],
        correctAnswer: "San Pedro"
    ),
    TriviaQuestion(
        question: "¿Qué significa 'Amén'?",
        options: ["Gracias", "Así sea", "Aleluya", "Perdón"],
        correctAnswer: "Así sea"
    ),
    TriviaQuestion(
        question: "¿Cuántos sacramentos hay en la Iglesia Católica?",
        options: ["5", "6", "7", "8"],
        correctAnswer: "7"
    ),
    TriviaQuestion(
        question: "¿Qué apóstol dudó de la resurrección de Jesús?",
        options: ["Pedro", "Tomás", "Judas Tadeo", "Andrés"],
        correctAnswer: "Tomás"
    ),
    TriviaQuestion(
        question: "¿Qué libro contiene los Salmos?",
        options: ["Éxodo", "Proverbios", "Salmos", "Levítico"],
        correctAnswer: "Salmos"
    ),
    TriviaQuestion(
        question: "¿Cuál es el tiempo litúrgico de preparación para la Navidad?",
        options: ["Cuaresma", "Adviento", "Pascua", "Epifanía"],
        correctAnswer: "Adviento"
    ),
    TriviaQuestion(
        question: "¿Quién es el patrono de las misiones?",
        options: ["San Ignacio de Loyola", "San Francisco Javier", "San Benito", "San José"],
        correctAnswer: "San Francisco Javier"
    ),
    TriviaQuestion(
        question: "¿Qué sacramento instituye el perdón de los pecados?",
        options: ["Confirmación", "Eucaristía", "Reconciliación", "Unción de los enfermos"],
        correctAnswer: "Reconciliación"
    ),
    TriviaQuestion(
        question: "¿Qué celebramos el 6 de enero?",
        options: ["Navidad", "Epifanía", "Ascensión", "Corpus Christi"],
        correctAnswer: "Epifanía"
    ),
    TriviaQuestion(
        question: "¿Quién es la madre de la Virgen María?",
        options: ["Marta", "Isabel", "Ana", "Elisabet"],
        correctAnswer: "Ana"
    ),
    TriviaQuestion(
        question: "¿Cuál es el último libro del Nuevo Testamento?",
        options: ["Hechos", "Romanos", "Apocalipsis", "Gálatas"],
        correctAnswer: "Apocalipsis"
    ),
    TriviaQuestion(
        question: "¿Qué significa 'católico'?",
        options: ["Universal", "Apóstol", "Servidor", "Elegido"],
        correctAnswer: "Universal"
    ),
    TriviaQuestion(
        question: "¿Qué ángel luchó contra el demonio según la tradición cristiana?",
        options: ["Rafael", "Gabriel", "Miguel", "Uriel"],
        correctAnswer: "Miguel"
    ),
    TriviaQuestion(
        question: "¿Qué día se celebra la fiesta de Todos los Santos?",
        options: ["31 de octubre", "1 de noviembre", "2 de noviembre", "25 de diciembre"],
        correctAnswer: "1 de noviembre"
    ),
    TriviaQuestion(
        question: "¿Qué papa fue conocido como el 'Papa viajero'?",
        options: ["Pablo VI", "Benedicto XVI", "Juan Pablo II", "Francisco"],
        correctAnswer: "Juan Pablo II"
    ),
    TriviaQuestion(
        question: "¿Cuál es el centro de la misa?",
        options: ["La homilía", "La consagración", "Las ofrendas", "El canto"],
        correctAnswer: "La consagración"
    ),
    TriviaQuestion(
        question: "¿A qué edad fue bautizado Jesús?",
        options: ["8 días", "A los 12 años", "A los 30 años", "No fue bautizado"],
        correctAnswer: "A los 30 años"
    ),
    TriviaQuestion(
        question: "¿Qué apóstol escribió el Apocalipsis?",
        options: ["Pedro", "Santiago", "Juan", "Pablo"],
        correctAnswer: "Juan"
    ),
    TriviaQuestion(
        question: "¿Cuál es el símbolo del Espíritu Santo?",
        options: ["Paloma", "Agua", "Aceite", "Pan"],
        correctAnswer: "Paloma"
    )
]
