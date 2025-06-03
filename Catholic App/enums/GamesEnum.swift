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
    )
]
