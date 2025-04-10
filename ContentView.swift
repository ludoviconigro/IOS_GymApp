import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("colorTheme") private var selectedColorTheme: AppColorTheme = .blue

    let workouts = [
        Workout(name: "1º Allenamento – Dorso/Bicipiti/Addome", exercises: [
            Exercise(name: "1.Sbarra", setsReps: "3 x max", muscle: "Dorso", imageName: "Sbarra.gif"),
            Exercise(name: "2.Lat Machine Avanti", setsReps: "3 x 12–10–8", muscle: "Dorso", imageName: "Lat_Machine_Avanti.gif"),
            Exercise(name: "3.Pullover con Manubrio", setsReps: "2 x 12–10", muscle: "Dorso", imageName: "Pullover_con_Manubrio.gif"),
            Exercise(name: "4.Lat Pulley", setsReps: "2 x 12–10", muscle: "Dorso", imageName: "Lat_Pulley.gif"),
            Exercise(name: "5.Row Alto Seduto", setsReps: "2 x 10–12", muscle: "Dorso", imageName: "Row_Alto_Seduto.gif"),
            Exercise(name: "6.Curl con Bilanciere", setsReps: "3 x 12–10–8", muscle: "Bicipiti", imageName: "Curl_con_Bilanciere.gif"),
            Exercise(name: "7.Curl Seduto con Manubri", setsReps: "2 x 8–6", muscle: "Bicipiti", imageName: "Curl_Seduto_con_Manubri.gif"),
            Exercise(name: "8.Curl Un Braccio", setsReps: "2–3 x 8–6", muscle: "Bicipiti", imageName: "Curl_Seduto_con_Manubri.gif"),
            Exercise(name: "9.Erettori Spinali", setsReps: "3 x 15", muscle: "Schiena", imageName: "Erettori_Spinali.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Addominali.gif")
        ]),
        Workout(name: "2º Allenamento – Petto/Tricipiti/Addome", exercises: [
            Exercise(name: "1.Panca Orizzontale Bilanciere", setsReps: "4 x 12–10–8–6", muscle: "Petto", imageName: "Panca_Orizzontale_Bilanciere.gif"),
            Exercise(name: "2.Croci Inclinata Pos.2", setsReps: "3 x 12–10–8", muscle: "Petto", imageName: "Croci_Inclinata_Pos.2.gif"),
            Exercise(name: "3.Panca Inclinata", setsReps: "2 x 10–12", muscle: "Petto", imageName: "Panca_Inclinata.gif"),
            Exercise(name: "4.Croci ai Cavi", setsReps: "2 x 10–12", muscle: "Petto", imageName: "Croci_ai_Cavi.gif"),
            Exercise(name: "5.Piegamenti", setsReps: "2 x max", muscle: "Petto", imageName: "Piegamenti.gif"),
            Exercise(name: "6.Tricipiti alla Combinata", setsReps: "2 x 8–6", muscle: "Tricipiti", imageName: "Tricipiti alla Combinata.gif"),
            Exercise(name: "7.French Press", setsReps: "3 x 8–6", muscle: "Tricipiti", imageName: "French_Press.gif"),
            Exercise(name: "8.Tricipiti Un Braccio", setsReps: "2 x 8–6", muscle: "Tricipiti", imageName: "Tricipiti_Un_Braccio.gif"),
            Exercise(name: "9.Erettori Spinali", setsReps: "3 x 15", muscle: "Schiena", imageName: "Erettori_Spinali.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Addominali.gif")
        ]),
        Workout(name: "3º Allenamento – Gambe/Spalle/Addome", exercises: [
            Exercise(name: "1.Pressa 45° o Squat", setsReps: "4 x 12–10–8–6", muscle: "Gambe", imageName: "Pressa_45_o_Squat.gif"),
            Exercise(name: "2.Leg Extension", setsReps: "2 x 10–8", muscle: "Gambe", imageName: "Leg_Extension.gif"),
            Exercise(name: "3.Leg Curling Standing", setsReps: "3 x 8–6", muscle: "Gambe", imageName: "Leg_Curling_Standing.gif"),
            Exercise(name: "4.Leg Curling Seated", setsReps: "3 x 8", muscle: "Gambe", imageName: "Leg_Curling_Seated.gif"),
            Exercise(name: "5.Calf in Piedi", setsReps: "3 x 15–12", muscle: "Gambe", imageName: "Calf_in_Piedi.gif"),
            Exercise(name: "6.Calf da Seduto", setsReps: "2 x 15–12", muscle: "Gambe", imageName: "Calf da Seduto.gif"),
            Exercise(name: "7.Distensioni con Manubri", setsReps: "3 x 12–10–8", muscle: "Spalle", imageName: "Distensioni con Manubri.gif"),
            Exercise(name: "8.Alzate Laterali", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "Alzate Laterali.gif"),
            Exercise(name: "9.Alzate Frontali", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "Alzate Frontali.gif"),
            Exercise(name: "10.Tirate al Mento", setsReps: "2 x 15–12", muscle: "Spalle", imageName: "Tirate al Mento.gif"),
            Exercise(name: "11.Adduzioni Dorsali", setsReps: "2 x 12", muscle: "Spalle", imageName: "Adduzioni Dorsali.gif"),
            Exercise(name: "Addome", setsReps: "8 x 30", muscle: "Addominali", imageName: "Addominali.gif")
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

                    NavigationLink(destination: PesoView()) {
                        Text("📉 Tracciamento Peso")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
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
