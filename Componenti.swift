import SwiftUI
import SDWebImageSwiftUI

struct WorkoutCard: View {
    var title: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: "dumbbell.fill")
                .font(.title2)
                .foregroundColor(color)
                .padding(.trailing, 8)

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct ExerciseCard: View {
    @Binding var exercise: Exercise
    @State private var showInfo = false
    @State private var showEdit = false
    @State private var tempWeight = ""
    @State private var tempNotes = ""
    @AppStorage("abilitaRecupero") private var abilitaRecupero: Bool = false
    var onSerieCompleted: (() -> Void)? = nil

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(exercise.name)
                            .font(.headline)
                        Text(exercise.muscle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(exercise.setsReps)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    if exercise.imageName != nil {
                        Button(action: {
                            withAnimation {
                                showInfo = true
                            }
                        }) {
                            Image(systemName: "info.circle")
                                .font(.title3)
                        }
                        .padding(.trailing, 4)
                    }

                    Button(action: {
                        tempWeight = exercise.weight ?? ""
                        tempNotes = exercise.notes ?? ""
                        withAnimation {
                            showEdit = true
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                    }
                    .padding(.trailing, 4)
                }

                HStack(spacing: 16) {
                    Button(action: {
                        if exercise.completedSets > 0 {
                            exercise.completedSets -= 1
                            updateCompletion()
                        }
                    }) {
                        Image(systemName: "minus")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text(exercise.isCompleted ? "Completato" : "\(exercise.completedSets) / \(exercise.totalSets) serie")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundColor(exercise.isCompleted ? .green : .primary)


                    Spacer()

                    Button(action: {
                        if exercise.completedSets < exercise.totalSets {
                            exercise.completedSets += 1
                            updateCompletion()
                            if abilitaRecupero {
                                onSerieCompleted?()
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

            // Popup GIF info
            if showInfo, let imageName = exercise.imageName {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                VStack(spacing: 16) {
                    Text(exercise.name)
                        .font(.headline)
                        .padding(.top)

                    AnimatedImage(name: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)

                    Button("Chiudi") {
                        withAnimation {
                            showInfo = false
                        }
                    }
                    .padding(.bottom)
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: 320)
                .padding()
                .background(Material.ultraThin)
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.scale)
            }

            // Popup Note/Peso
            if showEdit {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                VStack(spacing: 16) {
                    Text("Note & Peso")
                        .font(.headline)

                    TextField("Peso utilizzato", text: $tempWeight)
                        .textFieldStyle(.roundedBorder)

                    TextField("Note sull'esercizio", text: $tempNotes)
                        .textFieldStyle(.roundedBorder)

                    HStack(spacing: 16) {
                        Button("Annulla") {
                            withAnimation {
                                showEdit = false
                            }
                        }
                        .buttonStyle(.bordered)

                        Button("Salva") {
                            exercise.weight = tempWeight
                            exercise.notes = tempNotes
                            withAnimation {
                                showEdit = false
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .frame(maxWidth: 320)
                .padding()
                .background(Material.ultraThin)
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
    }

    func updateCompletion() {
        exercise.isCompleted = exercise.completedSets == exercise.totalSets
    }
    
}
