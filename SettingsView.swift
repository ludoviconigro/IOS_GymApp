import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("autoResetExercises") private var autoResetExercises: Bool = true
    @AppStorage("colorTheme") private var selectedColorTheme: AppColorTheme = .blue
    @AppStorage("abilitaRecupero") private var abilitaRecupero: Bool = false
    @AppStorage("durataRecupero") private var durataRecupero: Int = 60 // in secondi


    var body: some View {
        Form {
            Section(header: Text("Aspetto")) {
                Picker("Tema", selection: $selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.label).tag(theme)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Colore principale", selection: $selectedColorTheme) {
                    ForEach(AppColorTheme.allCases) { theme in
                        Text(theme.label).tag(theme)
                    }
                }
            }

            Section(header: Text("Allenamento")) {
                Toggle("Reset automatico esercizi completati", isOn: $autoResetExercises)
                Toggle("Abilita recupero tra esercizi", isOn: $abilitaRecupero)

                if abilitaRecupero {
                    Stepper("Tempo di recupero: \(durataRecupero) sec", value: $durataRecupero, in: 5...300, step: 5)
                }

            }
        }
        .navigationTitle("Impostazioni")
    }
}
