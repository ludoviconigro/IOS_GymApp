//
//  SchedaAllenamentoApp.swift
//  SchedaAllenamento
//
//  Created by Ludovico Nigro on 31/03/25.
//

import SwiftUI

@main
struct SchedaAllenamentoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
