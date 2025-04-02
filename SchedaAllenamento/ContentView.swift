import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("colorTheme") private var selectedColorTheme: AppColorTheme = .blue

    let workouts = [
        Workout(name: "1º Allenamento – Dorso/Bicipiti/Addome", exercises: [
            Exercise(name: "1.Sbarra", setsReps: "3 x max", muscle: "Dorso", imageName: "Brachialis-Pull-up.gif"),
            Exercise(name: "2.Lat Machine Avanti", setsReps: "3 x 12–10–8", muscle: "Dorso", imageName: "vitruvs.gif"),
            Exercise(name: "3.Pullover con Manubrio", setsReps: "2 x 12–10", muscle: "Dorso", imageName: "pullover dorso con manubrio.gif"),
            Exercise(name: "4.Lat Pulley", setsReps: "2 x 12–10", muscle: "Dorso", imageName: "a01e6e9ac81f3e913ec42ec5802c13a3.gif"),
            Exercise(name: "5.Row Alto Seduto", setsReps: "2 x 10–12", muscle: "Dorso", imageName: "23450.gif"),
            Exercise(name: "6.Curl con Bilanciere", setsReps: "3 x 12–10–8", muscle: "Bicipiti", imageName: "curl-bilanciere.gif"),
            Exercise(name: "7.Curl Seduto con Manubri", setsReps: "2 x 8–6", muscle: "Bicipiti", imageName: "curl-manubri-panca-inclinata.gif"),
            Exercise(name: "8.Curl Un Braccio", setsReps: "2–3 x 8–6", muscle: "Bicipiti", imageName: "curl-manubri-panca-inclinata.gif"),
            Exercise(name: "9.Erettori Spinali", setsReps: "3 x 15", muscle: "Schiena", imageName: "Twisting-Hyperextension.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Crunches-Giannis.gif")
        ]),
        Workout(name: "2º Allenamento – Petto/Tricipiti/Addome", exercises: [
            Exercise(name: "1.Panca Orizzontale Bilanciere", setsReps: "4 x 12–10–8–6", muscle: "Petto", imageName: "movimiento-del-press-inclinado-hacia-abajo.gif"),
            Exercise(name: "2.Croci Inclinata Pos.2", setsReps: "3 x 12–10–8", muscle: "Petto", imageName: "cómo-hacer-aperturas-inclinadas-con-mancuerna.gif"),
            Exercise(name: "3.Panca Inclinata", setsReps: "2 x 10–12", muscle: "Petto", imageName: "Barbell-Incline-Bench-Press_Chest_360.gif"),
            Exercise(name: "4.Croci ai Cavi", setsReps: "2 x 10–12", muscle: "Petto", imageName: "Croci-ai-cavi-alti.gif"),
            Exercise(name: "5.Piegamenti", setsReps: "2 x max", muscle: "Petto", imageName: "5.gif"),
            Exercise(name: "6.Tricipiti alla Combinata", setsReps: "2 x 8–6", muscle: "Tricipiti", imageName: "push-down-con-corda.0x0.93258.gif"),
            Exercise(name: "7.French Press", setsReps: "3 x 8–6", muscle: "Tricipiti", imageName: "65b9fd3e2a34af3567cc6441_french_press_triceps.gif"),
            Exercise(name: "8.Tricipiti Un Braccio", setsReps: "2 x 8–6", muscle: "Tricipiti", imageName: "unnamed.gif"),
            Exercise(name: "9.Erettori Spinali", setsReps: "3 x 15", muscle: "Schiena", imageName: "Twisting-Hyperextension.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Crunches-Giannis.gif")
        ]),
        Workout(name: "3º Allenamento – Gambe/Spalle/Addome", exercises: [
            Exercise(name: "1.Pressa 45° o Squat", setsReps: "4 x 12–10–8–6", muscle: "Gambe", imageName: "gym.gif"),
            Exercise(name: "2.Leg Extension", setsReps: "2 x 10–8", muscle: "Gambe", imageName: "LGE_EXT.gif"),
            Exercise(name: "3.Leg Curling Standing", setsReps: "3 x 8–6", muscle: "Gambe", imageName: "cable-leg-curl-exercise.gif"),
            Exercise(name: "4.Leg Curling Seated", setsReps: "3 x 8", muscle: "Gambe", imageName: "gym copia.gif"),
            Exercise(name: "5.Calf in Piedi", setsReps: "3 x 15–12", muscle: "Gambe", imageName: "eccentric-single-leg-calf-raise-calf-stretching-0028-652ef00e9074b.gif"),
            Exercise(name: "6.Calf da Seduto", setsReps: "2 x 15–12", muscle: "Gambe", imageName: "fd192bb6ef1ff52e0babb696c59500f1.gif"),
            Exercise(name: "7.Distensioni con Manubri", setsReps: "3 x 12–10–8", muscle: "Spalle", imageName: "manubri.0x0.91309.gif"),
            Exercise(name: "8.Alzate Laterali", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "alzate_laterali.gif"),
            Exercise(name: "9.Alzate Frontali", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "alzate-frontali.gif"),
            Exercise(name: "10.Tirate al Mento", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "exc006.gif"),
            Exercise(name: "11.Adduzioni Dorsali", setsReps: "2 x 12", muscle: "Spalle", imageName: "5338.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Crunches-Giannis.gif")
        ])
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            WorkoutCard(title: workout.name, color: selectedColorTheme.color)
                        }
                    }

                    NavigationLink(destination: SettingsView()) {
                        Text("⚙️ Impostazioni")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                }
                .padding()
            }
            .navigationTitle("Scheda Allenamento")
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
