import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("autoResetExercises") private var autoResetExercises: Bool = true
    @AppStorage("colorTheme") private var selectedColorTheme: AppColorTheme = .blue

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
            }
        }
        .navigationTitle("Impostazioni")
    }
}
