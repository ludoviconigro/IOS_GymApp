import SwiftUI
import Charts

struct PesoRecord: Identifiable, Codable {
    let id = UUID()
    let peso: Double
    let data: Date
}

struct PesoView: View {
    @AppStorage("storicoPeso") private var datiSalvati: Data = Data()
    @State private var peso: String = ""
    @State private var storico: [PesoRecord] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Tracciamento Peso")
                .font(.largeTitle)
                .bold()

            TextField("Inserisci il tuo peso (kg)", text: $peso)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Salva peso") {
                if let p = Double(peso) {
                    let nuovo = PesoRecord(peso: p, data: Date())
                    storico.append(nuovo)
                    saveData()
                    peso = ""
                }
            }
            .buttonStyle(.borderedProminent)

            if !storico.isEmpty {
                Chart(storico) {
                    LineMark(
                        x: .value("Data", $0.data),
                        y: .value("Peso", $0.peso)
                    )
                }
                .frame(height: 250)
                .padding()
            }

            Spacer()
        }
        .onAppear(perform: loadData)
        .padding()
    }

    func saveData() {
        if let encoded = try? JSONEncoder().encode(storico) {
            datiSalvati = encoded
        }
    }

    func loadData() {
        if let decoded = try? JSONDecoder().decode([PesoRecord].self, from: datiSalvati) {
            storico = decoded
        }
    }
}
