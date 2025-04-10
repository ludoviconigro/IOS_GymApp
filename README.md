# 💪 Scheda Allenamento (iOS App)

Una moderna app iOS sviluppata in SwiftUI per la gestione di schede di allenamento personalizzate. L'app consente di seguire i propri workout, visualizzare esercizi con immagini animate, monitorare il tempo di allenamento e tracciare l'andamento del peso corporeo.

## 📱 Funzionalità principali

- ✅ **Lista allenamenti**: schede suddivise per giorno e gruppo muscolare.
- 🏋️ **Esercizi con immagini animate**: GIF per ogni esercizio.
- ⏱ **Timer integrato per l'allenamento**.
- 🔄 **Reset automatico** degli esercizi completati.
- 🔔 **Timer di recupero** tra le serie (opzionale).
- 📉 **Tracciamento peso** con grafico storico.
- 🎨 **Temi personalizzabili** (chiaro/scuro/sistema + colore principale).
- ⚙️ **Impostazioni flessibili** per l'esperienza utente.

## 🗂 Struttura dei file

- `SchedaAllenamentoApp.swift`: entry point dell'app.
- `ContentView.swift`: vista principale con elenco allenamenti.
- `WorkoutDetailView.swift`: dettaglio dell’allenamento, timer, stato esercizi.
- `Componenti.swift`: componenti riutilizzabili (`WorkoutCard`, `ExerciseCard`).
- `Modelli.swift`: modelli dati (`Workout`, `Exercise`).
- `PesoView.swift`: interfaccia per tracciare il peso.
- `SettingsView.swift`: impostazioni dell'app.
- `Themes.swift`: gestione dei temi visivi.
- `Persistence.swift`: gestione della persistenza con CoreData.

## 🧪 Tecnologie usate

- **Swift 5+**
- **SwiftUI**
- **AppStorage / UserDefaults**
- **Charts framework** (per il tracciamento del peso)
- **SDWebImageSwiftUI** (per supporto GIF animate)
- **CoreData** (struttura predisposta per la persistenza)
