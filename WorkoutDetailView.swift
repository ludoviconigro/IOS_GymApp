import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @State private var exercises: [Exercise] = []
    @State private var timerRunning = false
    @State private var elapsedTime: Double = 0
    @State private var timer: Timer? = nil
    @State private var showCompletionAlert = false
    @AppStorage("autoResetExercises") private var autoResetExercises: Bool = true
    @AppStorage("abilitaRecupero") private var abilitaRecupero: Bool = false
    @AppStorage("durataRecupero") private var durataRecupero: Int = 60
    @State private var showRecuperoTimerForIndex: Int? = nil
    @State private var recuperoTimeRemaining = 0
    @State private var recuperoTimer: Timer? = nil

    private var storageKey: String {
        "completedExercises_\(workout.id.uuidString)"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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

                ForEach(exercises.indices, id: \.self) { index in
                    VStack(spacing: 8) {
                        ExerciseCard(exercise: $exercises[index], onSerieCompleted: {
                            if abilitaRecupero {
                                startRecuperoTimer(for: index)
                            }
                        })
                        .onChange(of: exercises[index].isCompleted) { _ in
                            saveExercises()
                            checkAndResetIfAllCompleted()
                        }

                        if showRecuperoTimerForIndex == index {
                            VStack(spacing: 4) {
                                Text("⏱ Recupero in corso")
                                Text("\(recuperoTimeRemaining) secondi")
                                    .font(.title3)
                                    .monospacedDigit()
                            }
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                        }
                    }
                }

                Button("🔄 Reset esercizi") {
                    for i in exercises.indices {
                        exercises[i].isCompleted = false
                        exercises[i].completedSets = 0
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
        .alert("🎉 Allenamento completato!", isPresented: $showCompletionAlert) {
            Button("OK", role: .cancel) {}
        }
    }

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

    func loadExercises() {
        let sharedDefaults = UserDefaults(suiteName: "group.prov.SchedaAllenamento")

        if let data = sharedDefaults?.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([Exercise].self, from: data) {
            exercises = saved
        } else {
            exercises = workout.exercises
        }
    }

    func saveExercises() {
        let sharedDefaults = UserDefaults(suiteName: "group.prov.SchedaAllenamento")

        if let data = try? JSONEncoder().encode(exercises) {
            sharedDefaults?.set(data, forKey: storageKey)
        }
    }

    func checkAndResetIfAllCompleted() {
        guard autoResetExercises else { return }

        let allCompleted = exercises.allSatisfy { $0.isCompleted }
        if allCompleted {
            showCompletionAlert = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                for i in exercises.indices {
                    exercises[i].isCompleted = false
                    exercises[i].completedSets = 0
                }
                saveExercises()
            }
        }
    }

    func startRecuperoTimer(for index: Int) {
        recuperoTimeRemaining = durataRecupero
        showRecuperoTimerForIndex = index

        recuperoTimer?.invalidate()
        recuperoTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if recuperoTimeRemaining > 0 {
                recuperoTimeRemaining -= 1
            } else {
                recuperoTimer?.invalidate()
                showRecuperoTimerForIndex = nil
            }
        }
    }
}
