import SwiftUI

struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let exercises: [Exercise]
}

struct Exercise: Identifiable, Codable {
    var id: UUID
    var name: String
    var setsReps: String
    var muscle: String
    var isCompleted: Bool = false
    var imageName: String? = nil  // ← nuovo campo per immagine/GIF

    init(id: UUID = UUID(), name: String, setsReps: String, muscle: String, isCompleted: Bool = false, imageName: String? = nil) {
        self.id = id
        self.name = name
        self.setsReps = setsReps
        self.muscle = muscle
        self.isCompleted = isCompleted
        self.imageName = imageName
    }
}

