import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @State private var exercises: [Exercise] = []
    @State private var timerRunning = false
    @State private var elapsedTime: Double = 0
    @State private var timer: Timer? = nil
    @AppStorage("autoResetExercises") private var autoResetExercises: Bool = true

    private var storageKey: String {
        "completedExercises_\(workout.id.uuidString)"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Cronometro
                VStack(spacing: 10) {
                    Text("Tempo allenamento")
                        .font(.headline)

                    Text(formatTime(elapsedTime))
                        .font(.system(size: 40, design: .monospaced))

                    HStack {
                        Button(timerRunning ? "Pausa" : "Avvia") {
                            timerRunning.toggle()
                            if timerRunning {
                                startTimer()
                            } else {
                                stopTimer()
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Reset") {
                            stopTimer()
                            elapsedTime = 0
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

                // Esercizi
                ForEach(exercises.indices, id: \.self) { index in
                    ExerciseCard(exercise: $exercises[index])
                        .onChange(of: exercises[index].isCompleted) {
                            saveExercises()
                            checkAndResetIfAllCompleted()
                        }
                }

                Button("🔄 Reset esercizi") {
                    for i in exercises.indices {
                        exercises[i].isCompleted = false
                    }
                    saveExercises()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .padding(.top)

            }
            .padding()
        }
        .navigationTitle(workout.name)
        .onAppear {
            loadExercises()
        }
        .onDisappear {
            stopTimer()
        }
    }

    // MARK: - Timer

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsedTime += 0.01
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let centiseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, centiseconds)
    }

    // MARK: - Esercizi: salvataggio

    func loadExercises() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([Exercise].self, from: data) {
            exercises = saved
        } else {
            exercises = workout.exercises
        }
    }

    func saveExercises() {
        if let data = try? JSONEncoder().encode(exercises) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    func checkAndResetIfAllCompleted() {
        guard autoResetExercises else { return }

        let allCompleted = exercises.allSatisfy { $0.isCompleted }
        if allCompleted {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                for i in exercises.indices {
                    exercises[i].isCompleted = false
                }
                saveExercises()
            }
        }
    }
}
