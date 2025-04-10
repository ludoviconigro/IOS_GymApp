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
    var imageName: String? = nil
    var weight: String? = nil
    var notes: String? = nil
    var completedSets: Int = 0

    var totalSets: Int {
        // Estrai il numero prima della "x", es: "3 x 12–10–8"
        let parts = setsReps.lowercased().split(separator: "x").map { $0.trimmingCharacters(in: .whitespaces) }
        if let firstPart = parts.first, let number = Int(firstPart) {
            return number
        }
        return 3 // fallback se il parsing fallisce
    }

    init(
        id: UUID = UUID(),
        name: String,
        setsReps: String,
        muscle: String,
        isCompleted: Bool = false,
        imageName: String? = nil,
        weight: String? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.setsReps = setsReps
        self.muscle = muscle
        self.isCompleted = isCompleted
        self.imageName = imageName
        self.weight = weight
        self.notes = notes
    }
}
